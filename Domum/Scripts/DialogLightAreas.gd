extends Spatial

func _ready():
	pass


func _on_AreaDialogLight2_body_entered(body : KinematicBody):
	if body:
		get_node("DialogLight")._setDialogLightText("Olhe Aren! A estátua do Fundador está logo à frente! Aquele senhor perto dela me parece familiar... fale com ele!", 5)
		get_node("../Player").can_run = true
		$AreaDialogLight2/CollisionShape.disabled = true
