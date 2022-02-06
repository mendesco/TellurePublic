extends Spatial

var checkpoint = Vector3()

onready var porta = $Collisions/Porta/AreaPorta/CollisionShape
var naPorta = false
onready var balde1 = $Collisions/Baldes/MeshInstance/Area1/CollisionShape
var balde_1 = false
onready var balde2 = $Collisions/Baldes/MeshInstance2/Area2/CollisionShape
var balde_2 = false
onready var balde3 = $Collisions/Baldes/MeshInstance3/Area3/CollisionShape
var balde_3 = false

onready var support = $LABAS/Navigation/Enemies

var baldeCount = 0
var vaza = false
var inPortaArea = false
var inAreaBalde = false
var takeBalde = false

onready var tween01 = $Audio/audio01/Tween01 as Tween
onready var tween02 = $Audio/audio02/Tween02 as Tween
onready var tween03 = $Audio/backsfx/Tween03 as Tween

onready var footsfx = $Player/footsfx as AudioStreamPlayer

func _ready():
	
	var checkpoint = get_node("Player").translation
	
	
	tween01.interpolate_property($Audio/audio01, "volume_db", $Audio/audio01.volume_db, 0, 8, Tween.TRANS_LINEAR, Tween.EASE_IN)
	tween01.start()
	tween03.interpolate_property($Audio/backsfx, "volume_db", $Audio/backsfx.volume_db, 10, 0.3, Tween.TRANS_LINEAR, Tween.EASE_IN)
	tween03.start()
	
	$Player.jump_height = 20
	$Player.walk_speed = 30
	$Player.sprint_speed = 40
	$Player/Vfx.visible = true
	
	get_node("Player/Death").visible = true
	get_node("Player/Death/AnimationPlayer").play_backwards("fade")
	yield(get_tree().create_timer(2), "timeout")
	get_node("Player/Death").visible = false
	
	porta.disabled = true
	
	balde_1 = false
	balde_2 = false
	balde_3 = false

func _process(_delta):
	
	if support.music == 1:
		tween01.interpolate_property($Audio/audio01, "volume_db", $Audio/audio01.volume_db, -80.1, 0.7, Tween.TRANS_LINEAR, Tween.EASE_IN)
		tween01.start()
		tween02.interpolate_property($Audio/audio02, "volume_db", $Audio/audio02.volume_db, 5, 0.1, Tween.TRANS_LINEAR, Tween.EASE_IN)
		tween02.start()
	else:
		tween01.interpolate_property($Audio/audio01, "volume_db", $Audio/audio01.volume_db, 0, 0.2, Tween.TRANS_LINEAR, Tween.EASE_IN)
		tween01.start()
		tween02.interpolate_property($Audio/audio02, "volume_db", $Audio/audio02.volume_db, -80.1, 0.2, Tween.TRANS_LINEAR, Tween.EASE_IN)
		tween02.start()
	
	if baldeCount == 3:
		vaza = true
		porta.disabled = false
	
	if Input.is_action_just_pressed("f") and $Player.can_press_f and inAreaBalde:
		baldeCount += 1
		$Audio/water_drop.play()
		if balde_1 == true:
			balde1.disabled = true
			balde_1 = false
			$Collisions/Baldes/MeshInstance/AnimationPlayer.play("collect")
			$Collisions/Baldes/BaldesIcone/BaldesFades.play("FadeBalde1")
			$Collisions/Baldes/BaldesIcone/Balde1.visible = true
		elif balde_2:
			balde2.disabled = true
			balde_2 = false
			$Collisions/Baldes/MeshInstance2/AnimationPlayer.play("collect")
			$Collisions/Baldes/BaldesIcone/BaldesFades.play("FadeBalde2")
			$Collisions/Baldes/BaldesIcone/Balde2.visible = true
		elif balde_3:
			balde3.disabled = true
			balde_3 = false
			$Collisions/Baldes/MeshInstance3/AnimationPlayer.play("collect")
			$Collisions/Baldes/BaldesIcone/BaldesFades.play("FadeBalde3")
			$Collisions/Baldes/BaldesIcone/Balde3.visible = true
	
	if Input.is_action_just_pressed("f") and $Player.can_press_f and vaza and inPortaArea == true:
		get_tree().change_scene("res://Green/greenOBJ.tscn")

	

func _physics_process(_delta):
	
	if support.dead:
		get_node("Player/Death").visible = true
		get_node("Player/Death/AnimationPlayer").play("fade")
		$Collisions/Baldes/BaldesIcone/BaldesFades.play_backwards("FadeBalde1")
		$Collisions/Baldes/BaldesIcone/BaldesFades.play_backwards("FadeBalde2")
		$Collisions/Baldes/BaldesIcone/BaldesFades.play_backwards("FadeBalde3")
#		get_tree().reload_current_scene()
		LoadingScreen.load_level("labpuzzel")
		
		
	
	if $Player.can_shake == false:
		footsfx.volume_db = -80.0
	
	if $Player.direction != Vector3() and !footsfx.volume_db == 10.0 and $Player.can_shake:
		footsfx.volume_db = 10.0
	if not $Player.direction != Vector3() and footsfx.volume_db == 10.0:
		footsfx.volume_db = -80.0
	
	if not $Player.is_on_floor():
		footsfx.volume_db = -80.0
	
	if $Player.direction != Vector3() and $Player.camsR == 1:
		footsfx.pitch_scale = 3
	if $Player.direction != Vector3() and $Player.camsR == 0:
		footsfx.pitch_scale = 2
	
	if Input.is_action_just_pressed("m"):
		$Map.visible = !$Map.visible
		$Map/MapSfx.play()

func _on_AreaPorta_body_entered(body):
	if body.is_in_group("Player"):
		get_node("Player/Head/AnimationPlayer").play("not_cam_shake")
		$Player/SpriteControler/Interagir/AnimationPlayer.play("fadein")
		$Player.can_press_f = true
		inPortaArea = true
		

func _on_AreaPorta_body_exited(body):
	if body.is_in_group("Player"):
		get_node("Player/Head/AnimationPlayer").play("cam_shake")
		$Player/SpriteControler/Interagir/AnimationPlayer.play_backwards("fadein")
		$Player.can_press_f = true
		inPortaArea = false


func _on_Area1_body_entered(body):
	if body.is_in_group("Player"):
		
		$Player/SpriteControler/Interagir.visible = true
		$Player/SpriteControler/Interagir/AnimationPlayer.play("fadein")
		$Player.can_press_f = true
		
		balde_1 = true
		
		inAreaBalde = true

func _on_Area1_body_exited(body):
	if body.is_in_group("Player"):
		
		$Player/SpriteControler/Interagir/AnimationPlayer.play_backwards("fadein")
		$Player.can_press_f = false
		
		balde_1 = false
		inAreaBalde = false


func _on_Area2_body_entered(body):
	if body.is_in_group("Player"):
		
		$Player/SpriteControler/Interagir.visible = true
		$Player/SpriteControler/Interagir/AnimationPlayer.play("fadein")
		$Player.can_press_f = true
		
		balde_2 = true
		inAreaBalde = true

func _on_Area2_body_exited(body):
	if body.is_in_group("Player"):
		
		$Player/SpriteControler/Interagir/AnimationPlayer.play_backwards("fadein")
		$Player.can_press_f = false
		
		balde_2 = false
		inAreaBalde = false


func _on_Area3_body_entered(body):
	if body.is_in_group("Player"):
		
		$Player/SpriteControler/Interagir.visible = true
		$Player/SpriteControler/Interagir/AnimationPlayer.play("fadein")
		$Player.can_press_f = true
		
		balde_3 = true
		inAreaBalde = true

func _on_Area3_body_exited(body):
	if body.is_in_group("Player"):
		
		$Player/SpriteControler/Interagir/AnimationPlayer.play_backwards("fadein")
		$Player.can_press_f = false
		
		balde_3 = false
		inAreaBalde = false
