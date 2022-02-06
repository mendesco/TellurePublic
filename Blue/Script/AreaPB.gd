extends Area

var is_On_AreaBinas

onready var Player = get_node("../../../Player") as player
onready var Pa = get_node("../../../Player/Head/Pa")
onready var Bi = get_node("../../../Player/Head/Binas") 
onready var SpController = get_node("../../../Player/SpriteControler/Interagir")
onready var Anm_player = get_node("../../../Player/SpriteControler/Interagir/AnimationPlayer") as AnimationPlayer


# Called when the node enters the scene tree for the first time.
func _ready():
	is_On_AreaBinas = false


func _process(_delta):
	if Input.is_action_just_pressed("f") and Player.can_press_f and is_On_AreaBinas:
		get_parent().queue_free()
		Player.has_Pa = false
		Pa.visible = false
		Player.has_binas = true
		Bi.visible = true
		get_node("../../../../blueOBJ").dialogLightText = "Parece que chegamos ao fim das charadas! Aperte [MOUSE1] para usar o binóculo!"
		get_node("../../LightDialog/DialogLight")._setDialogLightText(get_node("../../../../blueOBJ").dialogLightText, 5)
		get_node("../../../Objetos/Naufragio/PaLargada").visible = true
		get_node("../../Control/binpicksfx").play()


func _on_AreaPB_body_entered(body):
	if body.is_in_group("Player"):
		SpController.visible = true
		Anm_player.play("fadein")
		is_On_AreaBinas = true
		Player.can_press_f = true
		set_process(true)


func _on_AreaPB_body_exited(body):
	if body.is_in_group("Player"):
		Anm_player.play_backwards("fadein")
		is_On_AreaBinas = false
		Player.can_press_f = false
		set_process(false)
