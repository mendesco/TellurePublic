extends Area

var is_On_AreaG2

onready var Player = get_node("../../../Player") as player
onready var SpController = get_node("../../../Player/SpriteControler/Interagir")
onready var Anm_player = get_node("../../../Player/SpriteControler/Interagir/AnimationPlayer") as AnimationPlayer


# Called when the node enters the scene tree for the first time.
func _ready():
	is_On_AreaG2 = false



func _process(_delta):
	if Input.is_action_just_pressed("f") and Player.can_press_f and is_On_AreaG2 and get_node("../../LightDialog/DialogLight").imOnDialogLight == false:
		get_node("../../../Player/Head/PaCast").cast_to = Vector3(0,2,0)
		get_node("../../Control").visible = true
		get_node("../../Control/Garrafa2").visible = true
		get_node("../../../../blueOBJ").dialogLightText = "Não posso acreditar, Aren! Que trágico! Pelo visto temos que achar esse tal de lar..."
		Player.can_move = false
		Player.can_shake = false
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		
		get_node("../../Binoculo/AreaBinas/CollisionShape").disabled = false
		get_node("../../Control/bottlesfx").play()
		
	if get_node("../../Control").visible == true:
		if Input.is_action_just_pressed("ui_right"):
			_on_next_pressed()
		if Input.is_action_just_pressed("ui_left"):
			_on_back_pressed()
	
	
	if get_node("../../Control/Garrafa2/historia").visible == true:
		get_node("../../Control/Garrafa2/back").disabled = true
	else:
		get_node("../../Control/Garrafa2/back").disabled = false
		
	if get_node("../../Control/Garrafa2/charada2").visible == true:
		get_node("../../Control/Garrafa2/next").disabled = true
	else:
		get_node("../../Control/Garrafa2/next").disabled = false


func _on_AreaLeituraG2_body_entered(body):
	if body.is_in_group("Player"):
		SpController.visible = true
		Anm_player.play("fadein")
		is_On_AreaG2 = true
		Player.can_press_f = true
		set_process(true)


func _on_AreaLeituraG2_body_exited(body):
	if body.is_in_group("Player"):
		Anm_player.play_backwards("fadein")
		is_On_AreaG2 = false
		Player.can_press_f = false
		set_process(false)


func _on_next_pressed():
	if get_node("../../Control/Garrafa2/historia").visible == true:
		get_node("../../Control/Garrafa2/historia").visible = false
		get_node("../../Control/Garrafa2/charada").visible = true
	
	elif get_node("../../Control/Garrafa2/charada").visible == true:
		get_node("../../Control/Garrafa2/charada").visible = false
		get_node("../../Control/Garrafa2/charada2").visible = true
	
	if get_node("../../Control/Garrafa2/next").disabled == false:
		get_node("../../Control/pagesfx").play()
	elif get_node("../../Control/Garrafa2/next").disabled == true and !get_node("../../Control/pagesfx").is_playing():
		get_node("../../Control/pagesfx2").play()


func _on_back_pressed():
	if get_node("../../Control/Garrafa2/charada").visible == true:
		get_node("../../Control/Garrafa2/historia").visible = true
		get_node("../../Control/Garrafa2/charada").visible = false
	
	elif get_node("../../Control/Garrafa2/charada2").visible == true:
		get_node("../../Control/Garrafa2/charada").visible = true
		get_node("../../Control/Garrafa2/charada2").visible = false
	
	if get_node("../../Control/Garrafa2/back").disabled == false:
		get_node("../../Control/pagesfx").play()
	elif get_node("../../Control/Garrafa2/back").disabled == true and !get_node("../../Control/pagesfx").is_playing():
		get_node("../../Control/pagesfx2").play()
