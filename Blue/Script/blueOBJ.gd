extends Spatial

var bin = false
var dialogLightText = ""

onready var tween01 = $Audio/audio01/Tween01 as Tween
onready var tween02 = $Audio/audio02/Tween02 as Tween

var footsfx
onready var footsand = $Player/footsfx01 as AudioStreamPlayer
onready var footwood = $Player/footsfx02 as AudioStreamPlayer

func _ready():
	
	$Interactive/Control.visible = false
	$Player/Head/Binas/Control.visible = false
	$BinMeshes.visible = false
	
	$Interactive/TotemInicial/AreaTotemInicial/CollisionShape.disabled = false
	$Interactive/GarrafaPedra/AreaLeitruaGP/CollisionShape.disabled = true
	$Interactive/Garrafa1/AreaGarrafa/CollisionShape.disabled = true
	$Interactive/Garrafa2/AreaGarrafa/CollisionShape.disabled = true
	$Interactive/Binoculo/AreaBinas/CollisionShape.disabled = true
	$BinMeshes/Meshes/portaGlow/AreaTP/CollisionShape.disabled = true
	
	$Player/MeshInstance.visible = false
#	$Player.has_Pa = true
#	$Player/Head/Pa.visible = true
#	$Player.has_binas = true
	
	dialogLightText = "Chegamos! Vejo uma garrafa com uma mensagem a nossa frente..."
	$Interactive/LightDialog/DialogLight._setDialogLightText(dialogLightText, 4)
	
	tween01.interpolate_property($Audio/audio01, "volume_db", $Audio/audio01.volume_db, -10, 2, Tween.TRANS_LINEAR, Tween.EASE_IN)
	tween01.start()
	tween02.interpolate_property($Audio/audio02, "volume_db", $Audio/audio02.volume_db, -20, 3, Tween.TRANS_LINEAR, Tween.EASE_IN)
	tween02.start()
	
	get_node("Player/Death").visible = true
	get_node("Player/Death/AnimationPlayer").play_backwards("fade")
	yield(get_tree().create_timer(2), "timeout")
	get_node("Player/Death").visible = false
	
	footsfx = footsand


func _process(_delta):
	
	if $Player.has_binas == true:
		$BinMeshes/Meshes/portaGlow/AreaTP/CollisionShape.disabled = false
	
	if Input.is_action_just_pressed("m1") and $Player/Head/Binas.visible and !$Player/Head/Binas/AnimationPlayer.is_playing():
		if bin == false:
			$Player/Head/Binas/AnimationPlayer.play("bin")
			$BinMeshes/binSFX01.play()
			$BinMeshes/Timer.start()
#			binocular1()
		elif bin == true:
			$Player/Head/Binas/AnimationPlayer.play_backwards("bin")
			$BinMeshes/binSFX02.play()
			$BinMeshes/Timer.start()
#			binocular2()
	
	if Input.is_action_just_pressed("space") and $Interactive/Control.visible == true:
		_on_Button_pressed()
	

func _physics_process(_delta):
	
	if footsfx == footsand:
		_footsand()
	elif footsfx == footwood:
		_footwood()
	

func _footsand():
	if $Player.can_shake == false:
		footsfx.volume_db = -80.0
	
	if $Player.direction != Vector3() and !footsand.volume_db == -35.0 and $Player.can_shake:
		footsfx.volume_db = -35.0
	if not $Player.direction != Vector3() and footsand.volume_db == -35.0:
		footsfx.volume_db = -80.0
	
	if not $Player.is_on_floor():
		footsfx.volume_db = -80.0
	
	if $Player.direction != Vector3() and $Player.camsR == 1:
		footsfx.pitch_scale = 3
	if $Player.direction != Vector3() and $Player.camsR == 0:
		footsfx.pitch_scale = 2

func _footwood():
	if $Player.can_shake == false:
#		footsand.stop()
		footsfx.volume_db = -80.0
	
	if $Player.direction != Vector3() and !footsand.volume_db == -25.0 and $Player.can_shake:
#		footsand.play()
		footsfx.volume_db = -25.0
	if not $Player.direction != Vector3() and !footsand.volume_db == -25.0:
#		footsand.stop()
		footsfx.volume_db = -80.0
	
	if not $Player.is_on_floor():
#		footsand.stop()
		footsfx.volume_db = -80.0
	
	if $Player.direction != Vector3() and $Player.camsR == 1:
		footsfx.pitch_scale = 2
	if $Player.direction != Vector3() and $Player.camsR == 0:
		footsfx.pitch_scale = 1

func _on_Button_pressed():
	$Interactive/Control.visible = false
	$Interactive/Control/CharadaTotem.visible = false
	$Interactive/Control/Garrafa1.visible = false
	$Interactive/Control/GarrafaPedra.visible = false
	$Interactive/Control/Garrafa2.visible = false
	$Cavas/Garrafa/LG.visible = false
	$Player/Head/PaCast.cast_to = Vector3(0,2,-20)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	$Player.can_move = true
	$Player.can_shake = true
	
	$Interactive/Control/buttonsfx.play()
	
	$Interactive/LightDialog/DialogLight._setDialogLightText(dialogLightText, 6)

func _on_Player_desenterrado(AreaCavada):
	var collisionShapeArea = AreaCavada.get_child(0)
	collisionShapeArea.disabled = true
	var areaGarrafax = AreaCavada.get_parent()
	areaGarrafax.get_child(1).get_child(0).disabled = false
	$Player.desenterrar = 0

func binocular1():
	
#	$WorldEnvironment.environment.glow_intensity = 8
#	$WorldEnvironment.environment.glow_strength = 1.2
##	$WorldEnvironment.environment.glow_blend_mode = Environment.GLOW_BLEND_MODE_REPLACE
#	$WorldEnvironment.environment.glow_hdr_threshold = 0.34
#	$WorldEnvironment.environment.glow_hdr_scale = 4
	
	$Player/Vfx.visible = true
	$Player/Head/Binas/Control.visible = true
	bin = true
	
	$BinMeshes/Timer.start()

func binocular2():
#	$WorldEnvironment.environment.glow_intensity = 0.8
#	$WorldEnvironment.environment.glow_strength = 1
##	$WorldEnvironment.environment.glow_blend_mode = Environment.GLOW_BLEND_MODE_ADDITIVE
#	$WorldEnvironment.environment.glow_hdr_threshold = 0.34
#	$WorldEnvironment.environment.glow_hdr_scale = 4
	
	$Player/Vfx.visible = false
	$Player/Head/Binas/Control.visible = false
	bin = false
	
	$BinMeshes/Timer.start()


func _on_Timer_timeout():
	$Player/Vfx.visible = !$Player/Vfx.visible
	$Player/Head/Binas/Control.visible = !$Player/Head/Binas/Control.visible
	$BinMeshes.visible = !$BinMeshes.visible
	bin = !bin
	$BinMeshes/Timer.stop()


func _on_Area_body_entered(body):
	if body.is_in_group("Player"):
		footsfx = footwood
		footsand.volume_db = -80.0


func _on_Area_body_exited(body):
	if body.is_in_group("Player"):
		footsfx = footsand
		footwood.volume_db = -80.0


func _on_AreaTP_body_entered(body):
	if body.is_in_group("Player"):
		$Player.translation = Vector3(1521,13.1,1734)



