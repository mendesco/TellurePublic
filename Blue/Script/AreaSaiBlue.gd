extends Area

onready var Player = get_node("../../../Player") as player
onready var SpController = get_node("../../../Player/SpriteControler/Interagir")
onready var Anm_player = get_node("../../../Player/SpriteControler/Interagir/AnimationPlayer") as AnimationPlayer

var is_On_Area = false

func _process(delta):
	if Input.is_action_just_pressed("f") and Player.can_press_f and is_On_Area:
		GlobalGroundCondition.blueDialog = 2
		GlobalGroundCondition.comeBackRed = false
		GlobalGroundCondition.comeBackGreen = false
		GlobalGroundCondition.comeBackBlue = true
		LoadingScreen.load_level("domum")

func _on_AreaSaiBlue_body_entered(body):
	if body.is_in_group("Player"):
		SpController.visible = true
		Anm_player.play("fadein")
		is_On_Area = true
		Player.can_press_f = true
		set_process(true)


func _on_AreaSaiBlue_body_exited(body):
	if body.is_in_group("Player"):
		Anm_player.play_backwards("fadein")
		is_On_Area = false
		Player.can_press_f = false
		set_process(false)
