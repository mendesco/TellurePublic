extends Area

var is_On_AreaPa

onready var Player = get_node("../../../Player") as player
onready var Pa = get_node("../../../Player/Head/Pa") 
onready var SpController = get_node("../../../Player/SpriteControler/Interagir")
onready var Anm_player = get_node("../../../Player/SpriteControler/Interagir/AnimationPlayer") as AnimationPlayer


# Called when the node enters the scene tree for the first time.
func _ready():
	is_On_AreaPa = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("f") and Player.can_press_f and is_On_AreaPa:
		get_parent().queue_free()
		Player.has_Pa = true
		Pa.visible = true
		get_node("../../../../blueOBJ").dialogLightText = "Achamos a pá! Aperte [MOUSE1] para cavar!"
		get_node("../../LightDialog/DialogLight")._setDialogLightText(get_node("../../../../blueOBJ").dialogLightText, 4)
		get_node("../../Control/shovelsfx").play()


func _on_AreaPa_body_entered(body):
	if body.is_in_group("Player"):
		SpController.visible = true
		Anm_player.play("fadein")
		is_On_AreaPa = true
		Player.can_press_f = true


func _on_AreaPa_body_exited(body):
	if body.is_in_group("Player"):
		Anm_player.play_backwards("fadein")
		is_On_AreaPa = false
		Player.can_press_f = false
