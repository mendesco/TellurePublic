extends Button

export var caminho = ""
export(bool) var start_focused = false

func _ready():
	if(start_focused):
		grab_focus()
		
	connect("mouse_entered", self,"_on_Button_mouse_entered")
	connect("pressed",self,"_on_Button_Pressed")

func _on_Button_Pressed():
	if(caminho != ""):
		get_tree().change_scene(caminho)
	else:
		get_tree().quit()
		
