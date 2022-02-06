extends Button

export var caminho = ""
export(bool) var start_focused = false

func _ready():
	
	if(start_focused):
		grab_focus()
		

func _on_opcoes_Button_focus_entered():
	$AnimationPlayer.play("opcoes01")
	$button_SFX.play()

func _on_opcoes_Button_focus_exited():
	$AnimationPlayer.play("opcoes02")

func _on_opcoes_Button_mouse_entered():
	$AnimationPlayer.play("opcoes01")
	$button_SFX.play()

func _on_opcoes_Button_mouse_exited():
	$AnimationPlayer.play("opcoes02")
	
