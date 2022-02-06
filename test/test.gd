extends Spatial

onready var porta = $Collisions/Porta/AreaPorta/CollisionShape
var naPorta = false
onready var balde1 = $Collisions/Baldes/MeshInstance/Area1/CollisionShape
var balde_1 = false
onready var balde2 = $Collisions/Baldes/MeshInstance2/Area2/CollisionShape
var balde_2 = false
onready var balde3 = $Collisions/Baldes/MeshInstance3/Area3/CollisionShape
var balde_3 = false


var baldeCount = 0
var vaza = false

var takeBalde = false

func _ready():
	
	$Player.jump_height = 80
	
#	porta.translation = Vector3(0,-50,0)
	porta.disabled = true
	
	balde_1 = false
	balde_2 = false
	balde_3 = false

func _process(_delta):
	
	if baldeCount == 3:
		vaza = true
#		porta.translation = Vector3(0,0,0)
		porta.disabled = false
	
	if Input.is_action_just_pressed("f") and $Player.can_press_f:
		baldeCount += 1
		if balde_1 == true:
#			balde1.translation = Vector3(1,-50,1)
			balde1.disabled = true
			balde_1 = false
		elif balde_2:
#			balde2.translation = Vector3(1,-50,1)
			balde2.disabled = true
			balde_2 = false
		elif balde_3:
#			balde3.translation = Vector3(1,-50,1)
			balde3.disabled = true
			balde_3 = false
	
	if Input.is_action_just_pressed("f") and $Player.can_press_f and vaza:
		get_tree().reload_current_scene()

func _on_AreaPorta_body_entered(body):
	if body.is_in_group("Player"):
		
		$Player/SpriteControler/Interagir/AnimationPlayer.play("fadein")
		$Player.can_press_f = true
		

func _on_AreaPorta_body_exited(body):
	if body.is_in_group("Player"):
		
		$Player/SpriteControler/Interagir/AnimationPlayer.play_backwards("fadein")
		$Player.can_press_f = true
		


func _on_Area1_body_entered(body):
	if body.is_in_group("Player"):
		
		$Player/SpriteControler/Interagir.visible = true
		$Player/SpriteControler/Interagir/AnimationPlayer.play("fadein")
		$Player.can_press_f = true
		
		balde_1 = true

func _on_Area1_body_exited(body):
	if body.is_in_group("Player"):
		
		$Player/SpriteControler/Interagir/AnimationPlayer.play_backwards("fadein")
		$Player.can_press_f = false
		
		balde_1 = false


func _on_Area2_body_entered(body):
	if body.is_in_group("Player"):
		
		$Player/SpriteControler/Interagir.visible = true
		$Player/SpriteControler/Interagir/AnimationPlayer.play("fadein")
		$Player.can_press_f = true
		
		balde_2 = true

func _on_Area2_body_exited(body):
	if body.is_in_group("Player"):
		
		$Player/SpriteControler/Interagir/AnimationPlayer.play_backwards("fadein")
		$Player.can_press_f = false
		
		balde_2 = false


func _on_Area3_body_entered(body):
	if body.is_in_group("Player"):
		
		$Player/SpriteControler/Interagir.visible = true
		$Player/SpriteControler/Interagir/AnimationPlayer.play("fadein")
		$Player.can_press_f = true
		
		balde_3 = true

func _on_Area3_body_exited(body):
	if body.is_in_group("Player"):
		
		$Player/SpriteControler/Interagir/AnimationPlayer.play_backwards("fadein")
		$Player.can_press_f = false
		
		balde_3 = false
