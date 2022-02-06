extends Spatial

func _ready():
	pass

func _on_AreaDialogLight1_body_entered(body : KinematicBody):
	if body:
		get_node("DialogLight")._setDialogLightText("Chegamos Aren! Agora, encontre o ITEM MÍTICO!", 5)
		$AreaDialogLight1/CollisionShape.disabled = true

func _on_AreaDialogLight2_body_entered(body : KinematicBody):
	if body:
		get_node("DialogLight")._setDialogLightText("Veja Aren! Um pilar ativador! Ele deve fazer alguma coisa...", 5)
		$AreaDialogLight2/CollisionShape.disabled = true

func _on_AreaDialogLight3_body_entered(body : KinematicBody):
	if body:
		get_node("DialogLight")._setDialogLightText("Exite uma plataforma ativável à frente. Onde deve estar o pilar ativador dela...?", 5)
		$AreaDialogLight3/CollisionShape.disabled = true

func _on_AreaDialogLight4_body_entered(body : KinematicBody):
	if body:
		get_node("DialogLight")._setDialogLightText("Ótimo! Agora, devemos voltar e usar a plataforma ativável!", 5)
		$AreaDialogLight4/CollisionShape.disabled = true


func _on_AreaDialogLight5_body_entered(body : KinematicBody):
	if body:
		get_node("DialogLight")._setDialogLightText("Aren, um baú! O ITEM MÍTICO deve estar dentro dele! Mas veja, precisamos ligar estas lanternas antes...", 5)
		$AreaDialogLight5/CollisionShape.disabled = true
