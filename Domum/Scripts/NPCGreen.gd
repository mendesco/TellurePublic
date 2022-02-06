extends Spatial

export var bodyState = false
var dialog_is_finished = false

func _ready():
	$DialogGreen.visible = false

func _on_Area_body_entered(body : KinematicBody):
	if body:
		get_node("../Player").can_press_e = true
		get_node("../Player/SpriteControler/Falar").visible = true
		get_node("../Player/SpriteControler/Falar/AnimationPlayer").play("fadein")
		bodyState = true

func _getBodyState():
	return bodyState

func _on_Area_body_exited(body : KinematicBody):
	if body:
		bodyState = false
		$DialogGreen.visible = false
		get_node("../Player/SpriteControler/Falar/AnimationPlayer").play_backwards("fadein")
		get_node("../Player").can_press_e = false


func _on_Domum_interactGreen():
	$DialogGreen._nextPhraseGreen()
