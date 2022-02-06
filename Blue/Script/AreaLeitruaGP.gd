extends Area

var is_On_AreaGP

onready var Player = get_node("../../../Player") as player
onready var SpController = get_node("../../../Player/SpriteControler/Interagir")
onready var Anm_player = get_node("../../../Player/SpriteControler/Interagir/AnimationPlayer") as AnimationPlayer


# Called when the node enters the scene tree for the first time.
func _ready():
	is_On_AreaGP = false

func _process(_delta):
	if Input.is_action_just_pressed("f") and Player.can_press_f and is_On_AreaGP and get_node("../../LightDialog/DialogLight").imOnDialogLight == false:
		get_node("../../../Player/Head/PaCast").cast_to = Vector3(0,2,0)
		get_node("../../Control").visible = true
		get_node("../../Control/GarrafaPedra").visible = true
		get_node("../../../../blueOBJ").dialogLightText = "Que batalha épica! Precisamos de uma pá e descobrir onde eles descansaram..."
		Player.can_move = false
		Player.can_shake = false
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		
		get_node("../../Garrafa1/AreaGarrafa/CollisionShape").disabled = false
		get_node("../../Control/bottlesfx").play()
		
	if get_node("../../Control").visible == true:
		if Input.is_action_just_pressed("ui_right"):
			_on_next_pressed()
		if Input.is_action_just_pressed("ui_left"):
			_on_back_pressed()
	
	
	if get_node("../../Control/GarrafaPedra/historia").visible == true:
		get_node("../../Control/GarrafaPedra/back").disabled = true
	else:
		get_node("../../Control/GarrafaPedra/back").disabled = false
		
	if get_node("../../Control/GarrafaPedra/charada").visible == true:
		get_node("../../Control/GarrafaPedra/next").disabled = true
	else:
		get_node("../../Control/GarrafaPedra/next").disabled = false


func _on_AreaLeitruaGP_body_entered(body):
	if body.is_in_group("Player"):
		SpController.visible = true
		Anm_player.play("fadein")
		is_On_AreaGP = true
		Player.can_press_f = true
		set_process(true)


func _on_AreaLeitruaGP_body_exited(body):
	if body.is_in_group("Player"):
		Anm_player.play_backwards("fadein")
		is_On_AreaGP = false
		Player.can_press_f = false
		set_process(false)

func _on_next_pressed():
	get_node("../../Control/GarrafaPedra/historia").visible = false
	get_node("../../Control/GarrafaPedra/charada").visible = true
	
	if get_node("../../Control/GarrafaPedra/next").disabled == false:
		get_node("../../Control/pagesfx").play()
	elif get_node("../../Control/GarrafaPedra/next").disabled == true and !get_node("../../Control/pagesfx").is_playing():
		get_node("../../Control/pagesfx2").play()

func _on_back_pressed():
	get_node("../../Control/GarrafaPedra/historia").visible = true
	get_node("../../Control/GarrafaPedra/charada").visible = false
	
	if get_node("../../Control/GarrafaPedra/back").disabled == false:
		get_node("../../Control/pagesfx").play()
	elif get_node("../../Control/GarrafaPedra/back").disabled == true and !get_node("../../Control/pagesfx").is_playing():
		get_node("../../Control/pagesfx2").play()
