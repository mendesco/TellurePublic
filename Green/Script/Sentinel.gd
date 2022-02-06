extends KinematicBody

onready var player = $"../../../../Player" as KinematicBody
onready var VfxANM2 = $"../../../../Player/Vfx/AnimationPlayer2" as AnimationPlayer

onready var tween = $Tween

func _ready():
	$meshes/SpotLight.hide()
	$meshes/SpotLight2.hide()

func _process(_delta):
	if $meshes/SpotLight2.spot_angle == 20:
		get_tree().reload_current_scene()


func _on_Area_body_entered(body):
	if body.is_in_group("Player"):
		tween.interpolate_property($meshes/SpotLight, "light_color", $meshes/SpotLight.light_color, Color("ff0000"), 2, Tween.TRANS_LINEAR, Tween.EASE_IN)
		tween.interpolate_property($meshes/SpotLight2, "spot_angle", $meshes/SpotLight2.spot_angle, 20, 2, Tween.TRANS_LINEAR, Tween.EASE_IN)
		tween.interpolate_property($audio/audio, "volume_db", $audio/audio.volume_db, -25, 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN)
		tween.start()
		
		
		player.walk_speed = 10
		player.sprint_speed = 20
		VfxANM2.play("fade2")
#		mesh_anm2.play("detecting")


func _on_Area_body_exited(body):
	if body.is_in_group("Player"):
		tween.interpolate_property($meshes/SpotLight, "light_color", $meshes/SpotLight.light_color, Color("32cd00"), 2, Tween.TRANS_LINEAR, Tween.EASE_IN)
		tween.interpolate_property($meshes/SpotLight2, "spot_angle", $meshes/SpotLight2.spot_angle, 0.1, 2, Tween.TRANS_LINEAR, Tween.EASE_IN)
		tween.interpolate_property($audio/audio, "volume_db", $audio/audio.volume_db, -100, 1, Tween.TRANS_LINEAR, Tween.EASE_IN)
		tween.start()
		
		player.walk_speed = 30
		player.sprint_speed = 40
		VfxANM2.play_backwards("fade2")
		
#		mesh_anm2.play("q_detecting")


func _on_Area2_body_entered(body):
	if body.is_in_group("Player"):
		$meshes/SpotLight.show()
		$meshes/SpotLight2.show()


func _on_Area2_body_exited(body):
	if body.is_in_group("Player"):
		$meshes/SpotLight.hide()
		$meshes/SpotLight2.hide()
