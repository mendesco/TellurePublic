extends KinematicBody

var path = []
var path_node = 0

export var SPEED = 20
var speed = 20

onready var nav = get_node("../../..") as Navigation
onready var player = $"../../../../../Player" as KinematicBody
onready var Vfx = $"../../../../../Player/Vfx" as Control
onready var VfxANM = $"../../../../../Player/Vfx/AnimationPlayer1" as AnimationPlayer
onready var VfxANM2 = $"../../../../../Player/Vfx/AnimationPlayer2" as AnimationPlayer
onready var point = $"../Path/PathFollow/point" as KinematicBody

onready var green = get_node("../../../../..") as Spatial
onready var state = $BodyParticles/particles/AnimationPlayer as AnimationPlayer
onready var support = $"../.." as Spatial

var chasing = false

func _ready():
	state.play("idle")

func _physics_process(_delta):
	
	if support.areas == true:
		$AreaChase/CollisionShape.disabled = false
		$AreaAlert/CollisionShape.disabled = false
	else:
		$AreaChase/CollisionShape.disabled = true
		$AreaAlert/CollisionShape.disabled = true
	
	point.get_parent().offset += 0.5
	
	if path_node < path.size():
		var direction = (path[path_node] - global_transform.origin)
		if direction.length() < 1:
			path_node += 1
		else:
			move_and_slide(direction.normalized() * speed, Vector3.UP)


func move_to(target_pos):
	path = nav.get_simple_path(global_transform.origin, target_pos)
	path_node = 0


func _on_Timer_timeout():
	
	if support.a == 0:
		move_to(player.global_transform.origin)
	
	if support.a == 1:
		move_to(point.global_transform.origin)


func _on_AreaAlert_body_entered(body):
	if body.is_in_group("Player"):
		LoadingScreen.loading_death = true
#		chasing = true
		state.play("alert")
		support.a = 0
		VfxANM.play("fade1")

func _on_AreaAlert_body_exited(body):
	if body.is_in_group("Player"):
#		chasing = false
		state.play("idle")
		support.a = 1
		VfxANM.play_backwards("fade1")


func _on_AreaChase_body_entered(body):
	if body.is_in_group("Player"):
#		$AreaChase/CollisionShape.scale = Vector3(10,10,10)
#		$AreaAlert/CollisionShape.scale = Vector3(10,10,10)
		$AreaChase/CollisionShape.scale = Vector3(1.5,1.5,1.5)
		$AreaAlert/CollisionShape.scale = Vector3(1.5,1.5,1.5)
		chasing = true
		speed = 80
		support.a = 0
		support.music = 1
		state.play("chase")
		VfxANM2.play("fade2")


func _on_AreaChase_body_exited(body):
	if body.is_in_group("Player"):
		$AreaChase/CollisionShape.scale = Vector3(1,1,1)
		$AreaAlert/CollisionShape.scale = Vector3(1,1,1)
		chasing = true
		speed = 20
		support.a = 1
		support.music = 0
		state.play("alert")
		VfxANM2.play_backwards("fade2")


func _on_AreaKill_body_entered(body):
	if body.is_in_group("Player"):
		support.dead = true
