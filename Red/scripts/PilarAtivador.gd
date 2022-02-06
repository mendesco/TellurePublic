extends Spatial

signal active()

var can_activate = false


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _process(_delta):
	if Input.is_action_just_pressed("f") and can_activate and get_node("../../Player").can_press_f and !$sfx.playing:
#		print("passei aqui")
		emit_signal("active")
		$sfx.play()


func _on_Area_body_entered(body):
	if body.is_in_group("Player"):
#		print("entrei na area")
		can_activate = true
		get_node("../../Player").can_press_f = true
		get_node("../../Player/SpriteControler/Interagir").visible = true
		get_node("../../Player/SpriteControler/Interagir/AnimationPlayer").play("fadein")


func _on_Area_body_exited(body):
	if body.is_in_group("Player"):
#		print("entrei no area exited")
		can_activate = false
		get_node("../../Player/SpriteControler/Interagir/AnimationPlayer").play_backwards("fadein")
		get_node("../../Player").can_press_f = false
