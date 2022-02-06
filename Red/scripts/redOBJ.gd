extends Spatial

func _ready():
	
	$Player/MeshInstance.visible = false
	get_node("Player/Death").visible = true
	get_node("Player/Death/AnimationPlayer").play_backwards("fade")
	yield(get_tree().create_timer(2), "timeout")
	get_node("Player/Death").visible = false
	
	$Audio/music.play()
	$Audio/music/Tween.interpolate_property($Audio/music, "volume_db", $Audio/music.volume_db, -10, 3, Tween.TRANS_LINEAR, Tween.EASE_IN)
	$Audio/music/Tween.start()
	
	$Audio/backsfx.play()
	$Audio/backsfx/Tween.interpolate_property($Audio/backsfx, "volume_db", $Audio/backsfx.volume_db, -20, 4, Tween.TRANS_LINEAR, Tween.EASE_IN)
	$Audio/backsfx/Tween.start()
	

#func _process(delta):
#	if Input.is_action_just_pressed("f5"):
#		$Player.translation = Vector3(726.92,20.969,-421.475)
#	if Input.is_action_just_pressed("f6"):
#		$Player.translation = Vector3(385.071,20.969,104.507)
#	if Input.is_action_just_pressed("f7"):
#		$Player.translation = Vector3(289.645,68.188,987.686)
#	if Input.is_action_just_pressed("f9"):
#		$Player.translation = Vector3(856.558,54.904,1294.692)

