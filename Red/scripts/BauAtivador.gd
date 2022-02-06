extends Spatial

var can_activateChest = false
signal activateChest()

func _ready():
	pass

func _process(_delta):
	if Input.is_action_just_pressed("f") and can_activateChest and get_node("../../../Player").can_press_f:
		can_activateChest = false
		get_node("Area/CollisionShape").disabled = true
		emit_signal("activateChest")
		$AnimationPlayer.play("activate")
		$sfx.play()

func _on_Area_body_entered(body):
	if body.is_in_group("Player"):
		can_activateChest = true
		get_node("../../../Player").can_press_f = true
		get_node("../../../Player/SpriteControler/Interagir").visible = true
		get_node("../../../Player/SpriteControler/Interagir/AnimationPlayer").play("fadein")

func _on_Area_body_exited(body):
	if body.is_in_group("Player"):
		can_activateChest = false
		get_node("../../../Player/SpriteControler/Interagir/AnimationPlayer").play_backwards("fadein")
		get_node("../../../Player").can_press_f = false
