extends Area

var bodyEntredEnd = false
var pular = false

func _ready():
	pass

func _process(_delta):
	if Input.is_action_just_pressed("f") and bodyEntredEnd:
		get_node("../Player").can_move = false
		get_node("../AnimationPlayer/ColorRect").visible = true
		get_node("../AnimationPlayer").play("FadeIn")
		yield(get_node("../AnimationPlayer"), "animation_finished")
		get_node("../AnimationPlayer/ColorRect").visible = false
		get_node("../Sons/Areas/Yellow/sound01").stop()
		get_node("../Sons/Areas/Yellow/sound02").stop()
		get_node("../EndNode").visible = true
		get_node("../EndNode/EndMovie").play()

func _on_EndTrigger_body_entered(body : KinematicBody):
	if body:
		get_node("../Player/SpriteControler/Interagir").visible = true
		get_node("../Player/SpriteControler/Interagir/AnimationPlayer").play("fadein")
		bodyEntredEnd = true


func _on_EndTrigger_body_exited(body : KinematicBody):
	if body:
		get_node("../Player/SpriteControler/Interagir").visible = true
		get_node("../Player/SpriteControler/Interagir/AnimationPlayer").play_backwards("fadein")
		bodyEntredEnd = false


func _on_EndMovie_finished():
	GlobalGroundCondition.ground_condition = true
	GlobalGroundCondition.redDialog = 1
	GlobalGroundCondition.greenDialog = 1
	GlobalGroundCondition.blueDialog = 1
	GlobalGroundCondition.kingDialog = 1
	GlobalGroundCondition.velhoDialog = 1
	GlobalGroundCondition.showRedStone = false
	GlobalGroundCondition.showGreenStone = false
	GlobalGroundCondition.showBlueStone = false
	GlobalGroundCondition.stonesCount = 0
	GlobalGroundCondition.firstTimeInDomum = true
	GlobalGroundCondition.firstTimeInGreenOBJ = true
	GlobalGroundCondition.comeBackRed = false
	GlobalGroundCondition.comeBackGreen = false
	GlobalGroundCondition.comeBackBlue = false
	GlobalGroundCondition.allowTriggerRed = false
	GlobalGroundCondition.allowTriggerGreen = false
	GlobalGroundCondition.allowTriggerBlue = false
	LoadingScreen.load_level("menu")


func _on_AnimationPular_animation_finished(anim_name):
	if anim_name == "fade":
		pular = true
	if anim_name == "fade_back":
		pular = false

func _on_Timer_timeout():
	get_node("../EndNode/Pular/AnimationPular").play("fade_back")

func _input(event):
	if event is InputEventKey and event.pressed and pular == false:
		get_node("../EndNode/Pular/AnimationPular").play("fade")
		get_node("../EndNode/Pular/Timer").start()
	
	if Input.is_action_just_pressed("p") and get_node("../EndNode/EndMovie").is_playing() and pular == true:
		_on_EndMovie_finished()
