extends Spatial

var can_activate 


# Called when the node enters the scene tree for the first time.
func _ready():
	$Control.visible = false
	can_activate = false
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("f") and can_activate and get_node("../../../Player").can_press_f and !$Control.visible:
		$Control.visible = true
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		get_node("../../../Player").can_move = false
		get_node("../../../Player").can_shake = false
		$Control/Button.grab_focus()
		get_node("../../../Player/SpriteControler/Interagir").visible = false
		get_node("../../../Player/SpriteControler").visible = false
		
		$AnimationPlayer.play("fade")



func _on_Area_body_entered(body):
	if body.is_in_group("Player"):
		can_activate = true
		get_node("../../../Player").can_press_f = true
		get_node("../../../Player/SpriteControler/Interagir").visible = true
		get_node("../../../Player/SpriteControler/Interagir/AnimationPlayer").play("fadein")


func _on_Area_body_exited(body):
	if body.is_in_group("Player"):
		can_activate = false
		get_node("../../../Player").can_press_f = false
		get_node("../../../Player/SpriteControler/Interagir/AnimationPlayer").play_backwards("fadein")


func _on_Button_pressed():
	if $Control.visible:
		get_node("../../../Player").can_move = true
		get_node("../../../Player").can_shake = true
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		get_node("../../../Player/SpriteControler").visible = true
		get_node("../../../Player/SpriteControler/Interagir").visible = true
		get_node("../../../Player/SpriteControler/Interagir/AnimationPlayer").play("fadein")
		
		$AnimationPlayer2.play("fade_out")

func _on_AnimationPlayer2_animation_finished(anim_name):
	$Control.visible = false
	$AnimationPlayer.stop()
