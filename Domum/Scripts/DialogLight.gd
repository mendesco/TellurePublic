extends Control

var imOnDialogLight = false

func _ready():
	$dialogLight.visible = false
	$Light.visible = false
	$Text.visible = false

func _setDialogLightText(newText, time):
	imOnDialogLight = true
	$Text.bbcode_text = newText
	$LightFadeIn.play("LightFadeIn")
	$dialogLight.visible = true
	$Light.visible = true
	$Text.visible = true
	yield(get_tree().create_timer(time), "timeout")
	$LightFadeIn.play_backwards("LightFadeIn")
	imOnDialogLight = false
