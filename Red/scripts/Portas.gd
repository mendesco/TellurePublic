extends Spatial

#var can_activate 
#var open = false
#var inAreaPorta
#onready var pegarANplayer = get_node("../Player/SpriteControler/Pegar/AnimationPlayer")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
#	can_activate = false


#func _process(_delta):
#	if Input.is_action_just_pressed("f") and can_activate and get_node("../Player").can_press_f and !open and inAreaPorta:
#		$AnimationPlayer.play("open")
##		print("ta runfando")
#		open = true
#		$sfx.play()
#		get_node("../Player").can_press_f = false


func _on_Area_body_entered(body):
	if body.is_in_group("Player"):
		$AnimationPlayer.play("open")
		$sfx.play()
#		inAreaPorta = true
#		get_node("../Player").can_press_f = true
#		print("area da porta")
#		can_activate = true
#		get_node("../Player/SpriteControler/Interagir").visible = true
#		get_node("../Player/SpriteControler/Interagir/AnimationPlayer").play("fadein")


func _on_Area_body_exited(body):
	if body.is_in_group("Player"):
#		inAreaPorta = false
#		can_activate = false
#		get_node("../Player/SpriteControler/Interagir/AnimationPlayer").play_backwards("fadein")
#		yield(pegarANplayer, "animation_finished")
		$AnimationPlayer.play_backwards("open")
		$sfx.play()
#	if open:
#		$AnimationPlayer.play_backwards("open")
#		$sfx.play()


func _on_AnimationPlayer_animation_finished(anim_name):
	$sfx.stop()
	$sfx2.play()
