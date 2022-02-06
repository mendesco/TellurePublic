extends Area

onready var Player = get_node("../../../Player") as player
onready var SpController = get_node("../../../Player/SpriteControler/Interagir")
onready var Anm_player = get_node("../../../Player/SpriteControler/Interagir/AnimationPlayer") as AnimationPlayer
var is_On_AreaLG

func _ready():
	var is_On_AreaLG = false

func _process(delta):
	if Input.is_action_just_pressed("f") and Player.can_press_f and is_On_AreaLG and get_node("../../../Interactive/LightDialog/DialogLight").imOnDialogLight == false:
		get_node("../../../Player/Head/PaCast").cast_to = Vector3(0,2,0)
		get_node("../../../Interactive/Control").visible = true
		get_node("../../../Interactive/Control/Garrafa3").visible = true
		get_node("../../../../blueOBJ").dialogLightText = "Esse cara era mesmo um poeta! Vamos até o baú, Aren"
		Player.can_move = false
		Player.can_shake = false
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		
		get_node("../../Garrafa/AreaLG/CollisionShape").disabled = false
		get_node("../../../Interactive/Control/bottlesfx").play()
		
	if get_node("../../../Interactive/Control").visible == true:
		if Input.is_action_just_pressed("ui_right"):
			_on_next_pressed()
		if Input.is_action_just_pressed("ui_left"):
			_on_back_pressed()
	
	
	if get_node("../../../Interactive/Control/Garrafa3/historia").visible == true:
		get_node("../../../Interactive/Control/Garrafa3/back").disabled = true
	else:
		get_node("../../../Interactive/Control/Garrafa3/back").disabled = false
		
	if get_node("../../../Interactive/Control/Garrafa3/charada").visible == true:
		get_node("../../../Interactive/Control/Garrafa3/next").disabled = true
	else:
		get_node("../../../Interactive/Control/Garrafa3/next").disabled = false

func _on_AreaLG_body_entered(body):
	if body.is_in_group("Player"):
		SpController.visible = true
		Anm_player.play("fadein")
		is_On_AreaLG = true
		Player.can_press_f = true


func _on_AreaLG_body_exited(body):
	if body.is_in_group("Player"):
		Anm_player.play_backwards("fadein")
		is_On_AreaLG = false
		Player.can_press_f = false

func _on_next_pressed():
	get_node("../../../Interactive/Control/Garrafa3/historia").visible = false
	get_node("../../../Interactive/Control/Garrafa3/charada").visible = true
	
	if get_node("../../../Interactive/Control/Garrafa3/next").disabled == false:
		get_node("../../../Interactive/Control/pagesfx").play()
	elif get_node("../../../Interactive/Control/Garrafa3/next").disabled == true and !get_node("../../../Interactive/Control/pagesfx").is_playing():
		get_node("../../../Interactive/Control/pagesfx2").play()


func _on_back_pressed():
	get_node("../../../Interactive/Control/Garrafa3/historia").visible = true
	get_node("../../../Interactive/Control/Garrafa3/charada").visible = false
	
	if get_node("../../../Interactive/Control/Garrafa3/back").disabled == false:
		get_node("../../../Interactive/Control/pagesfx").play()
	elif get_node("../../../Interactive/Control/Garrafa3/back").disabled == true and !get_node("../../../Interactive/Control/pagesfx").is_playing():
		get_node("../../../Interactive/Control/pagesfx2").play()
