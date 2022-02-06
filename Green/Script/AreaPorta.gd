extends Area

export var level_to_load = ""

onready var player = get_node("../../../Player") as player
onready var SpController = get_node("../../../Player/SpriteControler/Interagir")
onready var Anm_player = get_node("../../../Player/SpriteControler/Interagir/AnimationPlayer") as AnimationPlayer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(_delta):
	if player.can_press_f and Input.is_action_just_pressed("f") and get_node("../../..").vaza:
		GlobalGroundCondition.firstTimeInGreenOBJ = false
		LoadingScreen.loading_death = false
		LoadingScreen.load_level(level_to_load)


func _on_AreaPorta_body_entered(body):
	if body.is_in_group("Player"):
		player.can_press_f = true
		SpController.visible = true
		Anm_player.play("fadein")


func _on_AreaPorta_body_exited(body):
	Anm_player.play_backwards("fadein")
	player.can_press_f = false
