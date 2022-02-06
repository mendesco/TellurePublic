extends Area

var bodyBlueEntered = false

func _ready():
	pass

func _process(_delta):
	if Input.is_action_just_pressed("f") and bodyBlueEntered:
		get_node("../Player").can_move = false
		get_node("../AnimationPlayer/ColorRect").visible = true
		get_node("../AnimationPlayer").play("FadeIn")
		yield(get_node("../AnimationPlayer"), "animation_finished")
		get_node("../Player").can_move = true
		get_node("../AnimationPlayer/ColorRect").visible = false
		LoadingScreen.load_level("blueobj")

func _on_BluePuzzelTrigger_body_entered(body : KinematicBody):
	if body and GlobalGroundCondition.allowTriggerBlue:
		get_node("../Player/SpriteControler/Interagir").visible = true
		get_node("../Player/SpriteControler/Interagir/AnimationPlayer").play("fadein")
		bodyBlueEntered = true

func _on_BluePuzzelTrigger_body_exited(body : KinematicBody):
	if body and GlobalGroundCondition.allowTriggerBlue:
		get_node("../Player/SpriteControler/Interagir").visible = true
		get_node("../Player/SpriteControler/Interagir/AnimationPlayer").play_backwards("fadein")
		bodyBlueEntered = false
