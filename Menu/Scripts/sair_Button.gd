extends Button

export var caminho = ""
export(bool) var start_focused = false

func _ready():
	if(start_focused):
		grab_focus()
		


func _on_sair_Button_focus_entered():
	$AnimationPlayer.play("sair01")
	$button_SFX.play()

func _on_sair_Button_focus_exited():
	$AnimationPlayer.play("sair02")

func _on_sair_Button_mouse_entered():
	$AnimationPlayer.play("sair01")
	$button_SFX.play()

func _on_sair_Button_mouse_exited():
	$AnimationPlayer.play("sair02")
	
