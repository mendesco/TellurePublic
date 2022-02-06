extends Spatial

func _ready():
	pass


func _on_Area_body_entered(body : KinematicBody):
	if body:
		get_node("DialogLight")._setDialogLightText("Chegamos Aren! Vamos começar a explorar...", 3)
		$Area/CollisionShape.disabled = true


func _on_Area2_body_entered(body : KinematicBody):
	if body:
		get_node("DialogLight")._setDialogLightText("Veja! Anos atrás, uma árvore ficava aqui. Acho que você deveria ler aquela placa.", 7)
		$Area2/CollisionShape.disabled = true
