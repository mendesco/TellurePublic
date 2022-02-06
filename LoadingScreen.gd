extends Control

var loader
var loading_status
var root
var cena_corrente

var loading_death 

onready var textureProgress = $TextureProgress

var level_adresses = {
	"labpuzzel": "res://Green/Scenes/LabPuzzle.tscn",
	"greenobj": "res://Green/greenOBJ.tscn",
	"redobj" : "res://Red/scenes/redOBJ.tscn",
	"blueobj": "res://Blue/Scenes/blueOBJ.tscn",
	"domum" : "res://Domum/Scenes/Domum.tscn",
	"menu" : "res://Menu/Scenes/Menu.tscn"
}

# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false
	root = get_tree().get_root()
	cena_corrente = root.get_child(root.get_child_count() -1)


func load_level(level):
	cena_corrente.queue_free()
	loader = ResourceLoader.load_interactive(level_adresses[level])
	if loader == null:
		return
	visible = true
	set_process(true)

func _process(_delta):
	if loader == null:
		set_process(false)
		return
	
	if loading_death:
		$VFP.visible = true
		$VFP2.visible = true
		$Carregando.visible = false
		$TresPontos.visible = false
		textureProgress.visible = false
	else:
		$VFP.visible = false
		$VFP2.visible = false
		$Carregando.visible = true
		$TresPontos.visible = true
		textureProgress.visible = true
	
#	anm_player.play("loading")
	
	loading_status = loader.poll()
	
	if loading_status == ERR_FILE_EOF:
		var loaded_level = loader.get_resource()
		visible = false
		loader = null 
		start_level(loaded_level)
	elif loading_status == OK:
		#continue to loading
		update_progress()
	else: 
		#error
		pass
	

func start_level(loaded_level):
	cena_corrente = loaded_level.instance() 
	root.add_child(cena_corrente)

func update_progress():
	var progress = float(loader.get_stage()) / loader.get_stage_count()
	textureProgress.value = progress * 100
