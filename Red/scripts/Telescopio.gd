extends Spatial

var can_activate = false

func _ready():
	$Control.visible = false

func _process(_delta):
	if Input.is_action_just_pressed("f") and can_activate and get_node("../../Player").can_press_f and !$Control.visible:
		$Control.visible = true
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		get_node("../../Player").can_move = false
		get_node("../../Player").can_shake = false
		$Control/Button.grab_focus()
		get_node("../../Player/SpriteControler/Interagir").visible = false
		get_node("../../Player/SpriteControler").visible = false
		$AnimationPlayer.play("FadeIn")
#		yield(get_tree().create_timer(1), "timeout")
		$AnimationPlayer2.play("StarAnimation")
		$AnimationPlayer3.play("CloudMov")
		get_node("../../Player/HUDStones").visible = false


func _on_Area_body_entered(body):
	if body.is_in_group("Player"):
		can_activate = true
		get_node("../../Player").can_press_f = true
		get_node("../../Player/SpriteControler/Interagir").visible = true
		get_node("../../Player/SpriteControler/Interagir/AnimationPlayer").play("fadein")

func _on_Area_body_exited(body):
	if body.is_in_group("Player"):
		can_activate = false
		get_node("../../Player").can_press_f = false
		get_node("../../Player/SpriteControler/Interagir/AnimationPlayer").play_backwards("fadein")


func _on_Button_pressed():
	if $Control.visible:
		get_node("../../Player").can_move = true
		get_node("../../Player").can_shake = true
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		get_node("../../Player/SpriteControler").visible = true
		get_node("../../Player/SpriteControler/Interagir").visible = true
		get_node("../../Player/SpriteControler/Interagir/AnimationPlayer").play("fadein")
		$AnimationPlayer.play_backwards("FadeIn")
		yield(get_tree().create_timer(1), "timeout")
		$Control.visible = false
		get_node("../../Player/HUDStones").visible = true
