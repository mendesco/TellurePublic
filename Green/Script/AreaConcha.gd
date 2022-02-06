extends Area

export var level_to_load = ""

onready var player = get_node("../../Player") as player
onready var SpController = get_node("../../Player/SpriteControler/Interagir")
onready var Anm_player = get_node("../../Player/SpriteControler/Interagir/AnimationPlayer") as AnimationPlayer

var areaconcha

# Called when the node enters the scene tree for the first time.
func _ready():
	areaconcha = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("f") and player.can_press_f == true and areaconcha:
		GlobalGroundCondition.comeBackRed = false
		GlobalGroundCondition.comeBackGreen = true
		GlobalGroundCondition.comeBackBlue = false
		GlobalGroundCondition.greenDialog = 2
		LoadingScreen.load_level("domum")


func _on_AreaConcha_body_entered(body):
	if body.is_in_group("Player"):
		areaconcha = true
		player.can_press_f = true
		SpController.visible = true
		Anm_player.play("fadein")


func _on_AreaConcha_body_exited(body):
	areaconcha = false
	Anm_player.play_backwards("fadein")
	player.can_press_f = false
