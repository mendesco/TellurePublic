extends Area

func _ready():
	pass

func _on_Area_de_Teste_body_entered(body : KinematicBody):
	if body:
		get_node("../NPCRed/DialogRed")._defineDialogPathRed(2)
		print("entrei aqui")
		print(get_node("../NPCRed/DialogRed").dialogPath)
