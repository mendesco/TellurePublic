extends Spatial

signal interactGreen()
signal interactRed()
signal interactBlue()
signal interactKing()
signal interactVelho()

export var interactState = false
export var bodyState = false

onready var footsfx = $Sons/footstep
onready var camera = $Inicio/Camera as Camera

var pular = false

var yellow_pos
var yellow_pos2
var green_pos
var green_pos2
var red_pos
var red_pos2
var blue_pos
var blue_pos2


func _ready():
	
	$Player/MeshInstance.visible = false
	get_node("Player/Death/ColorRect").visible = true
	get_node("Player/Death/AnimationPlayer").play_backwards("fade")
	$Inicio/Control.visible = false
	$EndTrigger/CollisionShape.disabled = true
#	$Player.scale = Vector3(0.7,0.7,0.7)
	
	if GlobalGroundCondition.firstTimeInDomum == true:
#		GlobalGroundCondition.stonesCount = 3
#		if GlobalGroundCondition.stonesCount == 3:
#			$EndTrigger/CollisionShape.disabled = false
#			$NPCVelho/StaticBody/Area/CollisionShape.disabled = true
#		# fim do teste
		$Player.can_move = false
		$Player.can_run = false
		$DialogLightAreas/AreaDialogLight2/CollisionShape.disabled = false
		GlobalGroundCondition.firstTimeInDomum = false
		cutsceneBegin()
		$Sons/intro.play()
		$Sons/Areas/Yellow/CollisionShape.disabled = true
		$Sons/Areas/Red/CollisionShape.disabled = true
		$Sons/Areas/Green/CollisionShape.disabled = true
		$Sons/Areas/Blue/CollisionShape.disabled = true
	else:
		$DialogLightAreas/AreaDialogLight2/CollisionShape.disabled = true
		
#		CONDIÇÕES PARA POSICIONAR O PLAYER CORRETAMENTE
		if GlobalGroundCondition.comeBackRed == true and GlobalGroundCondition.comeBackGreen == false and GlobalGroundCondition.comeBackBlue == false:
			$Player.translation = Vector3(-1312.393, 4.288, -53.665)
			$Player.rotation_degrees = Vector3(0, -90, 0)
			$DialogLightAreas/DialogLight._setDialogLightText("Ótimo trabalho! Leve o item até IZUNA YAMAGUCHI!", 2)
			get_node("Player/Death").visible = true
			get_node("Player/Death/AnimationPlayer").play_backwards("fade")
			yield(get_tree().create_timer(2), "timeout")
			get_node("Player/Death").visible = false
			$Inicio/Control.visible = false
			
		if GlobalGroundCondition.comeBackRed == false and GlobalGroundCondition.comeBackGreen == true and GlobalGroundCondition.comeBackBlue == false:
			$Player.translation = Vector3(-386.708, -363.587, -1111.344)
			$Player.rotation_degrees = Vector3(0, -180, 0)
			$DialogLightAreas/DialogLight._setDialogLightText("Conseguimos! Leve o item até BOHR!", 2)
			get_node("Player/Death").visible = true
			get_node("Player/Death/AnimationPlayer").play_backwards("fade")
			yield(get_tree().create_timer(2), "timeout")
			get_node("Player/Death").visible = false
			$Inicio/Control.visible = false
			
		if GlobalGroundCondition.comeBackRed == false and GlobalGroundCondition.comeBackGreen == false and GlobalGroundCondition.comeBackBlue == true:
			$Player.translation = Vector3(1102.305, -547.492, -264.054)
			$Player.rotation_degrees = Vector3(-0, -180, 0)
			$DialogLightAreas/DialogLight._setDialogLightText("Voltamos! Leve o item até KALE AWA!", 2)
			get_node("Player/Death").visible = true
			get_node("Player/Death/AnimationPlayer").play_backwards("fade")
			yield(get_tree().create_timer(2), "timeout")
			get_node("Player/Death").visible = false
			$Inicio/Control.visible = false
			
#		if GlobalGroundCondition.stonesCount == 3:
#			$EndTrigger/CollisionShape.disabled = false
#			$NPCVelho/StaticBody/Area/CollisionShape.disabled = true


func _physics_process(_delta):
	
	if $Player.can_shake == false:
		footsfx.volume_db = -80.0
	
	if $Player.direction != Vector3() and !footsfx.volume_db == -25.0 and $Player.can_shake:
		footsfx.volume_db = -25.0
	if not $Player.direction != Vector3() and footsfx.volume_db == -25.0:
		footsfx.volume_db = -80.0
	
	if not $Player.is_on_floor():
		footsfx.volume_db = -80.0
	
	if $Player.direction != Vector3() and $Player.camsR == 1:
		footsfx.pitch_scale = 3
	if $Player.direction != Vector3() and $Player.camsR == 0:
		footsfx.pitch_scale = 2
	

func _process(_delta):
	
	# ******************* FUNÇÕES DO VERDE ********************************
	# *********************************************************************
	if $NPCGreen.call("_getBodyState"):
		if Input.is_action_pressed("e") and $Player.can_press_e == true:
			interactState = true
			$Player.can_press_e = false
			$Player.can_move = false
			$Player.can_press_r = true
			$Player.can_shake = false
			if $DialogLightAreas/DialogLight.imOnDialogLight == true:
				$DialogLightAreas/DialogLight.visible = false
		
		if interactState and $NPCGreen.call("_getBodyState"):
			$AnimationPlayer/ColorRect.visible = true
			$AnimationPlayer.play("FadeIn")
	
		if $NPCGreen.dialog_is_finished:
			$Player.can_press_e = true
			$Player.can_press_r = false
			$Player.can_move = true
			$Player.can_shake = true
			$NPCGreen.dialog_is_finished = false
	
	# ******************* FUNÇÕES DO VERMELHO *****************************
	# *********************************************************************
	if $NPCRed.call("_getBodyState"):
		if Input.is_action_pressed("e") and $Player.can_press_e == true:
			interactState = true
			$Player.can_press_e = false
			$Player.can_move = false
			$Player.can_press_r = true
			$Player.can_shake = false
			if $DialogLightAreas/DialogLight.imOnDialogLight == true:
				$DialogLightAreas/DialogLight.visible = false
			
		
		if interactState and $NPCRed.call("_getBodyState"):
			$AnimationPlayer/ColorRect.visible = true
			$AnimationPlayer.play("FadeIn")
	
		if $NPCRed.dialog_is_finished:
			$Player.can_press_e = true
			$Player.can_press_r = false
			$Player.can_move = true
			$Player.can_shake = true
			$NPCRed.dialog_is_finished = false
	
	# ******************* FUNÇÕES DO AZUL *********************************
	# *********************************************************************
	if $NPCBlue.call("_getBodyState"):
		if Input.is_action_pressed("e") and $Player.can_press_e == true:
			interactState = true
			$Player.can_press_e = false
			$Player.can_press_r = true
			$Player.can_move = false
			$Player.can_shake = false
			if $DialogLightAreas/DialogLight.imOnDialogLight == true:
				$DialogLightAreas/DialogLight.visible = false
			
		
		if interactState and $NPCBlue.call("_getBodyState"):
			$AnimationPlayer/ColorRect.visible = true
			$AnimationPlayer.play("FadeIn")
	
		if $NPCBlue.dialog_is_finished:
			$Player.can_press_e = true
			$Player.can_press_r = false
			$Player.can_move = true
			$Player.can_shake = true
			$NPCBlue.dialog_is_finished = false
	
	# ******************* FUNÇÕES DO KING *********************************
	# *********************************************************************
	if $NPCKing.call("_getBodyState"):
		if Input.is_action_pressed("e") and $Player.can_press_e == true:
			interactState = true
			$Player.can_press_e = false
			$Player.can_press_r = true
			$Player.can_move = false
			$Player.can_shake = false
			if $DialogLightAreas/DialogLight.imOnDialogLight == true:
				$DialogLightAreas/DialogLight.visible = false
			
		
		if interactState and $NPCKing.call("_getBodyState"):
			$AnimationPlayer/ColorRect.visible = true
			$AnimationPlayer.play("FadeIn")
	
		if $NPCKing.dialog_is_finished:
			$Player.can_press_e = true
			$Player.can_press_r = false
			$Player.can_move = true
			$Player.can_shake = true
			$NPCKing.dialog_is_finished = false
	
	# ******************* FUNÇÕES DO VELHO ********************************
	# *********************************************************************
	if $NPCVelho.call("_getBodyState"):
		if Input.is_action_pressed("e") and $Player.can_press_e == true:
			interactState = true
			$Player.can_press_e = false
			$Player.can_press_r = true
			$Player.can_move = false
			$Player.can_shake = false
			if $DialogLightAreas/DialogLight.imOnDialogLight == true:
				$DialogLightAreas/DialogLight.visible = false
			
		
		if interactState and $NPCVelho.call("_getBodyState"):
			$AnimationPlayer/ColorRect.visible = true
			$AnimationPlayer.play("FadeIn")
	
		if $NPCVelho.dialog_is_finished:
			$Player.can_press_e = true
			$Player.can_press_r = false
			$Player.can_move = true
			$Player.can_shake = true
			$NPCVelho.dialog_is_finished = false
	

func _input(event):
	if Input.is_action_just_pressed("f5"):
		$Player.translation = Vector3(-1149.79, 20.809, -92.306)
#		GlobalGroundCondition.showRedStone = true
	if Input.is_action_just_pressed("f6"):
		$Player.translation = Vector3(-202.016, -334.436, -620.222)
#		GlobalGroundCondition.showGreenStone = true
	if Input.is_action_just_pressed("f7"):
		$Player.translation = Vector3(1103.792, 200.454, -25.326)
#		GlobalGroundCondition.showBlueStone = true
	
	if event is InputEventKey and event.pressed and $Inicio/AnimationCam.is_playing() and pular == false:
		$Inicio/Control/Pular/AnimationPular.play("fade")
		$Inicio/Control/Pular/Timer.start()
	
	if Input.is_action_just_pressed("p") and $Inicio/AnimationCam.is_playing() and pular == true and $Player.can_press_p == true:
		$Inicio/AnimationCam.stop()
		_on_AnimationCam_animation_finished("camera")
		$Inicio/Control.visible = false
		$Sons/intro.stop()
		$Player.can_press_p = false
		pular = false

func _on_AnimationPular_animation_finished(anim_name):
	if anim_name == "fade":
		pular = true
	if anim_name == "fade_back":
		pular = false

func _on_Timer_timeout():
	$Inicio/Control/Pular/AnimationPular.play("fade_back")
	

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "FadeIn":
		$AnimationPlayer/ColorRect.visible = false
		# VEREDE
		if $NPCGreen.call("_getBodyState"):
			#Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			$Player.transform = $NPCGreen.transform
			$Player.translation.z = $NPCGreen.translation.z + 20
			$Player/Head.rotation.x = deg2rad(0)
			$AnimationPlayer.play("FadeOut")
			emit_signal("interactGreen")
			$Player.can_press_e = false
			$Player.can_move = false
			$NPCGreen/DialogGreen.visible = true
			interactState = false
		# VERMELHO
		if $NPCRed.call("_getBodyState"):
			$Player.transform = $NPCRed.transform
			$Player.translation.x = $NPCRed.translation.x + 16
			$Player.translation.z = $NPCRed.translation.z - 10
			$Player/Head.rotation.x = deg2rad(0)
			$AnimationPlayer.play("FadeOut")
			emit_signal("interactRed")
			$Player.can_press_e = false
			$Player.can_move = false
			$NPCRed/DialogRed.visible = true
			interactState = false
		# AZUL
		if $NPCBlue.call("_getBodyState"):
			$Player.transform = $NPCBlue.transform
			$Player.translation.z = $NPCBlue.translation.z + 20
			$Player/Head.rotation.x = deg2rad(0)
			$AnimationPlayer.play("FadeOut")
			emit_signal("interactBlue")
			$Player.can_press_e = false
			$Player.can_move = false
			$NPCBlue/DialogBlue.visible = true
			interactState = false
		# KING
		if $NPCKing.call("_getBodyState"):
			$Player.transform = $NPCKing.transform
			$Player.translation.z = $NPCKing.translation.z - 20
			$Player/Head.rotation.x = deg2rad(0)
			$AnimationPlayer.play("FadeOut")
			emit_signal("interactKing")
			$Player.can_press_e = false
			$Player.can_move = false
			$NPCKing/DialogKing.visible = true
			interactState = false
		# VELHO
		if $NPCVelho.call("_getBodyState"):
			$Player.transform = $NPCVelho.transform
			$Player.translation.z = $NPCVelho.translation.z - 20
			$Player/Head.rotation.x = deg2rad(0)
			$AnimationPlayer.play("FadeOut")
			emit_signal("interactVelho")
			$Player.can_press_e = false
			$Player.can_move = false
			$NPCVelho/DialogVelho.visible = true
			interactState = false

func cutsceneBegin():
	$Player.translation = Vector3(-198.879, -414.742, 714.682)
	camera.current = true
	$Player/Head/Camera.current = false
	$Player/HUDStones.visible = false
	$Player.can_press_p = true
	$Inicio/Control.visible = true
	$Inicio/AnimationCam.play("camera")


func _on_AnimationCam_animation_finished(anim_name):
	if anim_name == "camera":
		$Sons/Areas/Yellow/CollisionShape.disabled = false
		$Sons/Areas/Red/CollisionShape.disabled = false
		$Sons/Areas/Green/CollisionShape.disabled = false
		$Sons/Areas/Blue/CollisionShape.disabled = false
		
		camera.current = false
		$Player/Head/Camera.current = true
		$Player/HUDStones.visible = true
		$Player.translation = Vector3(-198.879, -414.742, 730.188)
		$Player.can_press_p = false
		get_node("Player/Death").visible = true
		get_node("Player/Death/AnimationPlayer").play_backwards("fade")
		yield(get_tree().create_timer(2), "timeout")
		get_node("Player/Death").visible = false


func _on_Yellow_body_entered(body):
	if body.is_in_group("Player"):
		yellow_pos = $Sons/Areas/Yellow/sound01.get_playback_position()
		$Sons/Areas/Yellow/sound01.play(yellow_pos)
		$Sons/Areas/Yellow/sound01/Tween.interpolate_property($Sons/Areas/Yellow/sound01, "volume_db", $Sons/Areas/Yellow/sound01.volume_db, -20, 1, Tween.TRANS_LINEAR, Tween.EASE_IN)
		$Sons/Areas/Yellow/sound01/Tween.start()
		yellow_pos2 = $Sons/Areas/Yellow/sound02.get_playback_position()
		$Sons/Areas/Yellow/sound02.play(yellow_pos2)
		$Sons/Areas/Yellow/sound02/Tween.interpolate_property($Sons/Areas/Yellow/sound02, "volume_db", $Sons/Areas/Yellow/sound02.volume_db, -15, 1, Tween.TRANS_LINEAR, Tween.EASE_IN)
		$Sons/Areas/Yellow/sound02/Tween.start()
		
		$"Iluminação/DirectionalLight/Tween".interpolate_property($"Iluminação/DirectionalLight", "light_color", $"Iluminação/DirectionalLight".light_color, Color("f0efb0"), 2, Tween.TRANS_LINEAR, Tween.EASE_IN)
		$"Iluminação/DirectionalLight/Tween".start()
		
		if !$Sons/Areas/title/AnimationPlayer.is_playing():
			$Sons/Areas/title/AnimationPlayer.play("yellow")
func _on_Yellow_body_exited(body):
	if body.is_in_group("Player"):
		yellow_pos = $Sons/Areas/Yellow/sound01.get_playback_position()
		$Sons/Areas/Yellow/sound01/Tween.interpolate_property($Sons/Areas/Yellow/sound01, "volume_db", $Sons/Areas/Yellow/sound01.volume_db, -80, 1, Tween.TRANS_LINEAR, Tween.EASE_IN)
		$Sons/Areas/Yellow/sound01/Tween.start()
		yellow_pos2 = $Sons/Areas/Yellow/sound02.get_playback_position()
		$Sons/Areas/Yellow/sound02/Tween.interpolate_property($Sons/Areas/Yellow/sound02, "volume_db", $Sons/Areas/Yellow/sound02.volume_db, -80, 1, Tween.TRANS_LINEAR, Tween.EASE_IN)
		$Sons/Areas/Yellow/sound02/Tween.start()
		yield(get_tree().create_timer(1), "timeout")
		$Sons/Areas/Yellow/sound01.stop()
		$Sons/Areas/Yellow/sound02.stop()

func _on_Red_body_entered(body):
	if body.is_in_group("Player"):
		red_pos = $Sons/Areas/Red/sound01.get_playback_position()
		$Sons/Areas/Red/sound01.play(red_pos)
		$Sons/Areas/Red/sound01/Tween.interpolate_property($Sons/Areas/Red/sound01, "volume_db", $Sons/Areas/Red/sound01.volume_db, -25, 1, Tween.TRANS_LINEAR, Tween.EASE_IN)
		$Sons/Areas/Red/sound01/Tween.start()
		red_pos2 = $Sons/Areas/Red/sound02.get_playback_position()
		$Sons/Areas/Red/sound02.play(red_pos2)
		$Sons/Areas/Red/sound02/Tween.interpolate_property($Sons/Areas/Red/sound02, "volume_db", $Sons/Areas/Red/sound02.volume_db, -25, 1, Tween.TRANS_LINEAR, Tween.EASE_IN)
		$Sons/Areas/Red/sound02/Tween.start()
		
		$"Iluminação/DirectionalLight/Tween".interpolate_property($"Iluminação/DirectionalLight", "light_color", $"Iluminação/DirectionalLight".light_color, Color("ffb4b7"), 2, Tween.TRANS_LINEAR, Tween.EASE_IN)
		$"Iluminação/DirectionalLight/Tween".start()
		
		if !$Sons/Areas/title/AnimationPlayer.is_playing():
			$Sons/Areas/title/AnimationPlayer.play("red")
func _on_Red_body_exited(body):
	if body.is_in_group("Player"):
		red_pos = $Sons/Areas/Red/sound01.get_playback_position()
		$Sons/Areas/Red/sound01/Tween.interpolate_property($Sons/Areas/Red/sound01, "volume_db", $Sons/Areas/Red/sound01.volume_db, -80, 1, Tween.TRANS_LINEAR, Tween.EASE_IN)
		$Sons/Areas/Red/sound01/Tween.start()
		red_pos2 = $Sons/Areas/Red/sound02.get_playback_position()
		$Sons/Areas/Red/sound02/Tween.interpolate_property($Sons/Areas/Red/sound02, "volume_db", $Sons/Areas/Red/sound02.volume_db, -80, 1, Tween.TRANS_LINEAR, Tween.EASE_IN)
		$Sons/Areas/Red/sound02/Tween.start()
		yield(get_tree().create_timer(1), "timeout")
		$Sons/Areas/Red/sound01.stop()
		$Sons/Areas/Red/sound02.stop()

func _on_Green_body_entered(body):
	if body.is_in_group("Player"):
		green_pos = $Sons/Areas/Green/sound01.get_playback_position()
		$Sons/Areas/Green/sound01.play(green_pos)
		$Sons/Areas/Green/sound01/Tween.interpolate_property($Sons/Areas/Green/sound01, "volume_db", $Sons/Areas/Green/sound01.volume_db, -35, 1, Tween.TRANS_LINEAR, Tween.EASE_IN)
		$Sons/Areas/Green/sound01/Tween.start()
		
		$"Iluminação/DirectionalLight/Tween".interpolate_property($"Iluminação/DirectionalLight", "light_color", $"Iluminação/DirectionalLight".light_color, Color("4cd281"), 2, Tween.TRANS_LINEAR, Tween.EASE_IN)
		$"Iluminação/DirectionalLight/Tween".start()
		
		if !$Sons/Areas/title/AnimationPlayer.is_playing():
			$Sons/Areas/title/AnimationPlayer.play("green")
func _on_Green_body_exited(body):
	if body.is_in_group("Player"):
		green_pos = $Sons/Areas/Green/sound01.get_playback_position()
		$Sons/Areas/Green/sound01/Tween.interpolate_property($Sons/Areas/Green/sound01, "volume_db", $Sons/Areas/Green/sound01.volume_db, -80, 1, Tween.TRANS_LINEAR, Tween.EASE_IN)
		$Sons/Areas/Green/sound01/Tween.start()
		yield(get_tree().create_timer(1), "timeout")
		$Sons/Areas/Green/sound01.stop()

func _on_Blue_body_entered(body):
	if body.is_in_group("Player"):
		blue_pos = $Sons/Areas/Blue/sound01.get_playback_position()
		$Sons/Areas/Blue/sound01.play(blue_pos)
		$Sons/Areas/Blue/sound01/Tween.interpolate_property($Sons/Areas/Blue/sound01, "volume_db", $Sons/Areas/Blue/sound01.volume_db, -25, 1, Tween.TRANS_LINEAR, Tween.EASE_IN)
		$Sons/Areas/Blue/sound01/Tween.start()
		blue_pos2 = $Sons/Areas/Blue/sound02.get_playback_position()
		$Sons/Areas/Blue/sound02.play(blue_pos2)
		$Sons/Areas/Blue/sound02/Tween.interpolate_property($Sons/Areas/Blue/sound02, "volume_db", $Sons/Areas/Blue/sound02.volume_db, -38, 1, Tween.TRANS_LINEAR, Tween.EASE_IN)
		$Sons/Areas/Blue/sound02/Tween.start()
		
		$"Iluminação/DirectionalLight/Tween".interpolate_property($"Iluminação/DirectionalLight", "light_color", $"Iluminação/DirectionalLight".light_color, Color("aeadff"), 2, Tween.TRANS_LINEAR, Tween.EASE_IN)
		$"Iluminação/DirectionalLight/Tween".start()
		
		if !$Sons/Areas/title/AnimationPlayer.is_playing():
			$Sons/Areas/title/AnimationPlayer.play("blue")
func _on_Blue_body_exited(body):
	if body.is_in_group("Player"):
		blue_pos = $Sons/Areas/Blue/sound01.get_playback_position()
		$Sons/Areas/Blue/sound01/Tween.interpolate_property($Sons/Areas/Blue/sound01, "volume_db", $Sons/Areas/Blue/sound01.volume_db, -80, 1, Tween.TRANS_LINEAR, Tween.EASE_IN)
		$Sons/Areas/Blue/sound01/Tween.start()
		blue_pos2 = $Sons/Areas/Blue/sound02.get_playback_position()
		$Sons/Areas/Blue/sound02/Tween.interpolate_property($Sons/Areas/Blue/sound02, "volume_db", $Sons/Areas/Blue/sound02.volume_db, -80, 1, Tween.TRANS_LINEAR, Tween.EASE_IN)
		$Sons/Areas/Blue/sound02/Tween.start()
		yield(get_tree().create_timer(1), "timeout")
		$Sons/Areas/Blue/sound01.stop()
		$Sons/Areas/Blue/sound02.stop()
