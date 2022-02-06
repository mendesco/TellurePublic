extends Area

var bodyRedEntered = false

func _ready():
	pass

func _process(_delta):
	if Input.is_action_just_pressed("f") and bodyRedEntered:
		get_node("../Player").can_move = false
		get_node("../AnimationPlayer/ColorRect").visible = true
		get_node("../AnimationPlayer").play("FadeIn")
		yield(get_node("../AnimationPlayer"), "animation_finished")
		get_node("../Player").can_move = true
		get_node("../AnimationPlayer/ColorRect").visible = false
		LoadingScreen.load_level("redobj")
#		if get_tree().change_scene("res://Red/scenes/redOBJ.tscn") != OK:
#			print ("An unexpected error occured when trying to switch to the Readme scene")

func _on_RedPuzzelTrigger_body_entered(body : KinematicBody):
	if body and GlobalGroundCondition.allowTriggerRed:
		get_node("../Player/SpriteControler/Interagir").visible = true
		get_node("../Player/SpriteControler/Interagir/AnimationPlayer").play("fadein")
		bodyRedEntered = true


func _on_RedPuzzelTrigger_body_exited(body : KinematicBody):
	if body and GlobalGroundCondition.allowTriggerRed:
		get_node("../Player/SpriteControler/Interagir/AnimationPlayer").play_backwards("fadein")
		bodyRedEntered = false
