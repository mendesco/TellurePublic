extends Area

var is_On_AreaTotem

onready var Player = get_node("../../../Player") as player
onready var SpController = get_node("../../../Player/SpriteControler/Interagir")
onready var Anm_player = get_node("../../../Player/SpriteControler/Interagir/AnimationPlayer") as AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	is_On_AreaTotem =  false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("f") and Player.can_press_f and is_On_AreaTotem and get_node("../../LightDialog/DialogLight").imOnDialogLight == false:
		get_node("../../../Player/Head/PaCast").cast_to = Vector3(0,2,0)
		get_node("../../Control").visible = true
		get_node("../../Control/CharadaTotem").visible = true
		get_node("../../../../blueOBJ").dialogLightText = "Aren, nossa primeira charada! Parece que ela fala sobre o pôr do Sol... Vamos explorar o lugar!"
		Player.can_move = false
		Player.can_shake = false
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		
		get_node("../../GarrafaPedra/AreaLeitruaGP/CollisionShape").disabled = false
		get_node("../../Control/bottlesfx").play()
		
	if get_node("../../Control").visible == true:
		if Input.is_action_just_pressed("ui_right"):
			_on_next_pressed()
		if Input.is_action_just_pressed("ui_left"):
			_on_back_pressed()
	
	
	if get_node("../../Control/CharadaTotem/historia").visible == true:
		get_node("../../Control/CharadaTotem/back").disabled = true
	else:
		get_node("../../Control/CharadaTotem/back").disabled = false
		
	if get_node("../../Control/CharadaTotem/charada").visible == true:
		get_node("../../Control/CharadaTotem/next").disabled = true
	else:
		get_node("../../Control/CharadaTotem/next").disabled = false


func _on_AreaTotemInicial_body_entered(body):
	if body.is_in_group("Player"):
		SpController.visible = true
		Anm_player.play("fadein")
		is_On_AreaTotem = true
		Player.can_press_f = true


func _on_AreaTotemInicial_body_exited(body):
	if body.is_in_group("Player"):
		Anm_player.play_backwards("fadein")
		is_On_AreaTotem = false
		Player.can_press_f = false


func _on_next_pressed():
	get_node("../../Control/CharadaTotem/historia").visible = false
	get_node("../../Control/CharadaTotem/charada").visible = true
	
	if get_node("../../Control/CharadaTotem/next").disabled == false:
		get_node("../../Control/pagesfx").play()
	elif get_node("../../Control/CharadaTotem/next").disabled == true and !get_node("../../Control/pagesfx").is_playing():
		get_node("../../Control/pagesfx2").play()


func _on_back_pressed():
	get_node("../../Control/CharadaTotem/historia").visible = true
	get_node("../../Control/CharadaTotem/charada").visible = false
	
	if get_node("../../Control/CharadaTotem/back").disabled == false:
		get_node("../../Control/pagesfx").play()
	elif get_node("../../Control/CharadaTotem/back").disabled == true and !get_node("../../Control/pagesfx").is_playing():
		get_node("../../Control/pagesfx2").play()
