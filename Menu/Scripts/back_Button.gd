extends Button

export var caminho = ""
export(bool) var start_focused = false

func _ready():
	if(start_focused):
		grab_focus()
		

func _on_back_Button_focus_entered():
	$button_SFX.play()

func _on_back_Button_mouse_entered():
	$button_SFX.play()


