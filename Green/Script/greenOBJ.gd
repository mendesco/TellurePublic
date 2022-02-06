extends Spatial

onready var footsfx = $Player/footsfx as AudioStreamPlayer
onready var tween01 = $Audio/audio01/Tween01 as Tween
onready var tween02 = $Audio/backsfx/Tween02 as Tween

var onTheArea = false
var onTheAreaTree = false
var onTheAreaConcha = false

func _ready():
	
	$Player/MeshInstance.visible = false
	$Tree/AreaConcha/CollisionShape.disabled = true
	$Tree/AreaTree/CollisionShape.disabled = true
	$Tree/Arvore2/StaticBody/CollisionShape.disabled = true
	$Tree/Arvore2/StaticBody/CollisionShape2.disabled = true
	$Tree/Control.visible = false
	$Tree/Arvore2.visible = false
	
	tween01.interpolate_property($Audio/audio01, "volume_db", $Audio/audio01.volume_db, 0, 1, Tween.TRANS_LINEAR, Tween.EASE_IN)
	tween01.start()
	tween02.interpolate_property($Audio/backsfx, "volume_db", $Audio/backsfx.volume_db, 2, 2, Tween.TRANS_LINEAR, Tween.EASE_IN)
	tween02.start()
	
	if GlobalGroundCondition.firstTimeInGreenOBJ == false:
		$Tree/AreaTree/CollisionShape.disabled = false
		$AreaLightDialog/Area/CollisionShape.disabled = true
		$AreaLightDialog/Area2/CollisionShape.disabled = true
		$entrance/Trigger_Lab/CollisionShape.disabled = true
		$Player.translation = Vector3(-515.8, 4.29, 10.73)
		$Player.rotation_degrees = Vector3(0, -90, 0)
		$AreaLightDialog/DialogLight._setDialogLightText("Conseguimos! Agora, leve os três baldes até a muda.", 5)
	
	get_node("Player/Death").visible = true
	get_node("Player/Death/AnimationPlayer").play_backwards("fade")
	yield(get_tree().create_timer(2), "timeout")
	get_node("Player/Death").visible = false
	

func _process(_delta):
	
	if Input.is_action_just_pressed("f") and $Player.can_press_f == true and onTheAreaTree == true:
		$Player.can_move = false
		$Player.can_shake = false
		get_node("Player/Death").visible = true
		get_node("Player/Death/AnimationPlayer").play("fade")
		yield(get_tree().create_timer(2), "timeout")
		ActivateTree()
		get_node("Player/Death").visible = false
	
	
	if Input.is_action_just_pressed("p"):
		print($Player.translation)
		print($Player.rotation_degrees)
		print($Player/Head.rotation_degrees)

func ActivateTree():
	$Tree/Control.visible = true
	$Tree/Arvore2/StaticBody/CollisionShape.disabled = false
	$Tree/Arvore2/StaticBody/CollisionShape2.disabled = false
	$Tree/Control/AnimationPlayer.play("fade")
	$Tree/Control/VideoPlayer.play()
	
	$Player.translation = Vector3(-403.743591, 13.17242, 5.552139)
	$Player.rotation_degrees = Vector3(-0, 92.979996, 0)
	$Player/Head.rotation_degrees = Vector3(8.259987, 0, 0)
	
	onTheAreaTree == false

func _physics_process(_delta):
	
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

func _on_Trigger_Lab_body_entered(body):
	if body.is_in_group("Player"):
		$Player/SpriteControler/Interagir.visible = true
		$Player/SpriteControler/Interagir/AnimationPlayer.play("fadein")
		$Player.can_press_f = true
		onTheArea = true


func _on_Trigger_Lab_body_exited(body):
	if body.is_in_group("Player"):
		$Player/SpriteControler/Interagir/AnimationPlayer.play_backwards("fadein")
		$Player.can_press_f = false
		onTheArea = false


func _on_AreaTree_body_entered(body):
	if body.is_in_group("Player"):
		$Player/SpriteControler/Interagir.visible = true
		$Player/SpriteControler/Interagir/AnimationPlayer.play("fadein")
		$Player.can_press_f = true
		onTheAreaTree = true


func _on_AreaTree_body_exited(body):
	if body.is_in_group("Player"):
		$Player/SpriteControler/Interagir/AnimationPlayer.play_backwards("fadein")
		$Player.can_press_f = false
		onTheAreaTree = false


func _on_VideoPlayer_finished():
	$Tree/Control/AnimationPlayer.play_backwards("fade")
	
	$Player.translation = Vector3(-403.743591, 13.17242, 5.552139)
	$Player.rotation_degrees = Vector3(-0, 92.979996, 0)
	$Player/Head.rotation_degrees = Vector3(8.259987, 0, 0)
	$Tree/Arvore2.visible = true
	yield(get_tree().create_timer(0.5), "timeout")
	$Tree/Control.visible = false
	$Tree/AreaTree/CollisionShape.disabled = true
	$Tree/AreaConcha/CollisionShape.disabled = false
	$Player.can_move = true
	$Player.can_shake = true


func _on_AreaConcha_body_entered(body):
	if body.is_in_group("Player"):
		$Player/SpriteControler/Interagir.visible = true
		$Player/SpriteControler/Interagir/AnimationPlayer.play("fadein")
		$Player.can_press_f = true
		
		onTheAreaConcha = true


func _on_AreaConcha_body_exited(body):
	if body.is_in_group("Player"):
		$Player/SpriteControler/Interagir/AnimationPlayer.play_backwards("fadein")
		$Player.can_press_f = false
		
		onTheAreaConcha = false
