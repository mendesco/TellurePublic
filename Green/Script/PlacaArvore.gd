extends Spatial

var active_placa

func _ready():
	$Control.visible = false
	active_placa = false

func _process(_delta):
	if Input.is_action_just_pressed("f") and active_placa and get_node("../../Player").can_press_f and !$Control.visible:
		$Control.visible = true
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		get_node("../../Player").can_move = false
		get_node("../../Player").can_shake = false
		$Control/Button.grab_focus()
		get_node("../../Player/SpriteControler/Interagir").visible = false
		get_node("../../Player/SpriteControler").visible = false
		$Control/AnimationsPlaca.play("Surgir")

func _on_AreaPlaca_body_entered(body):
	if body.is_in_group("Player"):
		active_placa = true
		get_node("../../Player").can_press_f = true
		get_node("../../Player/SpriteControler/Interagir").visible = true
		get_node("../../Player/SpriteControler/Interagir/AnimationPlayer").play("fadein")


func _on_AreaPlaca_body_exited(body):
	if body.is_in_group("Player"):
		active_placa = false
		get_node("../../Player").can_press_f = false
		get_node("../../Player/SpriteControler/Interagir/AnimationPlayer").play_backwards("fadein")


func _on_Button_pressed():
	if $Control.visible:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		get_node("../../Player/SpriteControler").visible = true
		get_node("../../Player/SpriteControler/Interagir").visible = true
		get_node("../../Player/SpriteControler/Interagir/AnimationPlayer").play("fadein")
		$Control/AnimationsPlaca.play_backwards("Surgir")
		get_node("../../Player").can_move = true
		get_node("../../Player").can_shake = true
		yield(get_tree().create_timer(2), "timeout")
		$Control.visible = false
