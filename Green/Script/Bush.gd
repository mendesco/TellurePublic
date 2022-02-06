extends Spatial

onready var player = $"../../../../Player" as KinematicBody
onready var breath = $"../../../../Player/breath" as AudioStreamPlayer
onready var VfxANM3 = $"../../../../Player/Vfx/AnimationPlayer3" as AnimationPlayer
onready var coll = $"../../../../Player/CollisionShape" as CollisionShape
onready var enemy = $"../../Enemies/Enemy/Enemy" as KinematicBody
onready var state = $"../../Enemies/Enemy/Enemy/BodyParticles/particles/AnimationPlayer" as AnimationPlayer
onready var alert = $"../../Enemies/Enemy/Enemy/AreaAlert/CollisionShape" as CollisionShape
onready var chase = $"../../Enemies/Enemy/Enemy/AreaChase/CollisionShape" as CollisionShape
onready var enemies_sup = $"../../Enemies" as Spatial

func _ready():
	pass # Replace with function body.


func _on_Area_body_entered(body):
	if body.is_in_group("Player"):
		$Scatter/ScatterPoint.radius = 3
#		alert.scale = Vector3(0.1,0.1,0.1)
#		chase.scale = Vector3(0.1,0.1,0.1)
#		enemy.chasing = false
		enemies_sup.a = 1
		enemies_sup.areas = false
#		coll.disabled = true
		state.play("idle")
		VfxANM3.play("fade1")
		breath.play()




func _on_Area_body_exited(body):
	if body.is_in_group("Player"):
		$Scatter/ScatterPoint.radius = 1
		enemies_sup.areas = true
#		coll.disabled = false
		VfxANM3.play_backwards("fade1")
		breath.stop()
#		alert.disabled = false
#		chase.disabled = false
#		alert.scale = Vector3(1,1,1)
#		chase.scale = Vector3(1,1,1)
