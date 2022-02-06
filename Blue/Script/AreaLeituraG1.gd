extends Area

var is_On_AreaG1

onready var Player = get_node("../../../Player") as player
onready var SpController = get_node("../../../Player/SpriteControler/Interagir")
onready var Anm_player = get_node("../../../Player/SpriteControler/Interagir/AnimationPlayer") as AnimationPlayer


# Called when the node enters the scene tree for the first time.
func _ready():
	is_On_AreaG1 = false


func _process(_delta):
	if Input.is_action_just_pressed("f") and Player.can_press_f and is_On_AreaG1 and get_node("../../LightDialog/DialogLight").imOnDialogLight == false:
		get_node("../../../Player/Head/PaCast").cast_to = Vector3(0,2,0)
		get_node("../../Control").visible = true
		get_node("../../Control/Garrafa1").visible = true
		get_node("../../../../blueOBJ").dialogLightText = "Três peças, juntas? Do que será que ele estava falando? Vamos procurar pela ilha..."
		Player.can_move = false
		Player.can_shake = false
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		
		get_node("../../Garrafa2/AreaGarrafa/CollisionShape").disabled = false
		get_node("../../Control/bottlesfx").play()
		
	if get_node("../../Control").visible == true:
		if Input.is_action_just_pressed("ui_right"):
			_on_next_pressed()
		if Input.is_action_just_pressed("ui_left"):
			_on_back_pressed()
	
	
	if get_node("../../Control/Garrafa1/historia").visible == true:
		get_node("../../Control/Garrafa1/back").disabled = true
	else:
		get_node("../../Control/Garrafa1/back").disabled = false
		
	if get_node("../../Control/Garrafa1/charada").visible == true:
		get_node("../../Control/Garrafa1/next").disabled = true
	else:
		get_node("../../Control/Garrafa1/next").disabled = false


func _on_AreaLeitura_body_entered(body):
	if body.is_in_group("Player"):
		SpController.visible = true
		Anm_player.play("fadein")
		is_On_AreaG1 = true
		Player.can_press_f = true
		set_process(true)


func _on_AreaLeitura_body_exited(body):
	if body.is_in_group("Player"):
		Anm_player.play_backwards("fadein")
		is_On_AreaG1 = false
		Player.can_press_f = false
		set_process(false)


func _on_next_pressed():
	get_node("../../Control/Garrafa1/historia").visible = false
	get_node("../../Control/Garrafa1/charada").visible = true
	
	if get_node("../../Control/Garrafa1/next").disabled == false:
		get_node("../../Control/pagesfx").play()
	elif get_node("../../Control/Garrafa1/next").disabled == true and !get_node("../../Control/pagesfx").is_playing():
		get_node("../../Control/pagesfx2").play()


func _on_back_pressed():
	get_node("../../Control/Garrafa1/historia").visible = true
	get_node("../../Control/Garrafa1/charada").visible = false
	
	if get_node("../../Control/Garrafa1/back").disabled == false:
		get_node("../../Control/pagesfx").play()
	elif get_node("../../Control/Garrafa1/back").disabled == true and !get_node("../../Control/pagesfx").is_playing():
		get_node("../../Control/pagesfx2").play()
