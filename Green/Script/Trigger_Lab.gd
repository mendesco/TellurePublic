extends Area

export var level_to_load = ""

onready var player = get_node("../../Player") as player
onready var SpController = get_node("../../Player/SpriteControler/Interagir")
onready var Anm_player = get_node("../../Player/SpriteControler/Interagir/AnimationPlayer") as AnimationPlayer

var isInTriggerArea = false

func _ready():
	pass


func _process(_delta):
	if player.can_press_f and Input.is_action_just_pressed("f") and GlobalGroundCondition.firstTimeInGreenOBJ == true and isInTriggerArea == true:
		GlobalGroundCondition.firstTimeInGreenOBJ = false
		LoadingScreen.load_level(level_to_load)


func _on_Trigger_Lab_body_entered(body):
	if body.is_in_group("Player"):
		isInTriggerArea = true
		player.can_press_f = true
		SpController.visible = true
		Anm_player.play("fadein")


func _on_Trigger_Lab_body_exited(body):
	if body.is_in_group("Player"):
		isInTriggerArea = false
		player.can_press_f = false
		Anm_player.play_backwards("fadein")

