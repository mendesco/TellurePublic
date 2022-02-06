extends KinematicBody
class_name player

var mouse_sensitivity = 0.07

onready var b_decal = preload("res://Blue/Scenes/Bullet_Decal.tscn")

onready var head = $Head
onready var cam = $Head/Camera
onready var ground_check = $GroundCheck
onready var tutu = $Head/cam_Tween
onready var fov = $Head/Camera.fov
onready var cam_anm = $Head/AnimationPlayer

var can_move = true
var can_run = true
var can_press_e = false
var can_press_r = false
var can_press_p = false
var can_press_esc 
var can_shake = true
var climbing = false
var can_press_f = false
var ground_condition

# Move
var velocity := Vector3()
var direction := Vector3()
var move_axis := Vector2()
var sprint_enabled := true
var sprinting := false
# Walk
const FLOOR_MAX_ANGLE: float = deg2rad(46.0)
export(float) var gravity = 40
export(int) var walk_speed = 40
export(int) var sprint_speed = 60
export(int) var acceleration = 8
export(int) var deacceleration = 8
export(float, 0.0, 1.0, 0.05) var air_control = 0.3
export(int) var jump_height = 50
# Fly
export(int) var fly_speed = 10
export(int) var fly_accel = 4
var flying := false

var gravity_vec = Vector3()
var movement = Vector3()
var h_velocity = Vector3()
var camsR = 0
var full_contact = false
var h_acceleration = 60
var air_acceleration = 10
var normal_acceleration = 60

var has_Pa = false
var desenterrar = 0
signal desenterrado(AreaCavada)

var has_binas = false

##################################################

# Called when the node enters the scene tree
func _ready():
	$Head/Binas.visible = false
	$Head/Binas/Control.visible = false
	$Head/PaCast.enabled = false
	$Head/Pa.visible = false
	$Menu_Domum.visible = false
	$SpriteControler/Falar.visible = false
	$SpriteControler/Pegar.visible = false
	$SpriteControler/Interagir.visible = false
	$Vfx.visible = false
	$Death.visible = false
	
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	if GlobalGroundCondition.showRedStone == true:
		$HUDStones/HUDAnimationStones.play("HUDREDStoneFade")
		$HUDStones/HUDREDStone.visible = true
		yield(get_tree().create_timer(2),"timeout")
	if GlobalGroundCondition.showGreenStone == true:
		$HUDStones/HUDAnimationStones.play("HUDGREENStoneFade")
		$HUDStones/HUDGREENStone.visible = true
		yield(get_tree().create_timer(2),"timeout")
	if GlobalGroundCondition.showBlueStone == true:
		$HUDStones/HUDAnimationStones.play("HUDBLUEStoneFade")
		$HUDStones/HUDBLUEStone.visible = true
		yield(get_tree().create_timer(2),"timeout")

# Called every physics tick. 'delta' is constant
func _physics_process(delta: float) -> void:
	if climbing:
		fly(delta)
	elif can_move:
		walk(delta)
	
	cam_run()
	
	if direction != Vector3() and can_shake and is_on_floor():
		cam_anm.play("cam_shake")

func cam_run():
	if camsR == 1:
		fov = $Head/Camera.fov
		tutu.interpolate_property(cam, "fov", fov, 70.0, 0.1, Tween.TRANS_BOUNCE, Tween.EASE_IN)
		tutu.start()
	
	elif camsR == 0:
		fov = $Head/Camera.fov
		tutu.interpolate_property(cam, "fov", fov, 50.0, 0.1, Tween.TRANS_BOUNCE, Tween.EASE_IN)
		tutu.start()
	
func walk(delta: float) -> void:
	# Input
	
	ground_condition = GlobalGroundCondition.ground_condition
	
	direction = Vector3()
	var aim: Basis = get_global_transform().basis
	if move_axis.x >= 0.5:
		direction -= aim.z
	if move_axis.x <= -0.5:
		direction += aim.z
	if move_axis.y <= -0.5:
		direction -= aim.x
	if move_axis.y >= 0.5:
		direction += aim.x
	direction.y = 0
	direction = direction.normalized()
	
	# Jump
	var _snap: Vector3
	if is_on_floor():
		_snap = Vector3.DOWN
		if Input.is_action_just_pressed("space") and can_move and can_press_esc:
			_snap = Vector3.ZERO
			velocity.y = jump_height
	
	# Apply Gravity
	velocity.y -= gravity * delta
	
	# Sprint
	var _speed
	if (Input.is_action_pressed("shift") and can_sprint() and can_run and move_axis.x >= 0.5):
		camsR = 1
		_speed = sprint_speed
		sprinting = true
	else:
		camsR = 0
		_speed = walk_speed
		sprinting = false
	
	
	# Apply Gravity
	velocity.y -= gravity * delta
	
	# Sprint
	
	if (Input.is_action_pressed("shift") and can_sprint() and can_run and move_axis.x >= 0.5):
		camsR = 1
		_speed = sprint_speed
		sprinting = true
	else:
		camsR = 0
		_speed = walk_speed
		sprinting = false
	
	# Acceleration and Deacceleration
	# where would the player go
	var _temp_vel: Vector3 = velocity
	_temp_vel.y = 0
	var _target: Vector3 = direction * _speed
	var _temp_accel: float
	if direction.dot(_temp_vel) > 0:
		_temp_accel = acceleration
	else:
		_temp_accel = deacceleration
	if not is_on_floor():
		_temp_accel *= air_control
	# interpolation
	_temp_vel = _temp_vel.linear_interpolate(_target, _temp_accel * delta)
	velocity.x = _temp_vel.x
	velocity.z = _temp_vel.z
	# clamping (to stop on slopes)
	if direction.dot(velocity) == 0:
		var _vel_clamp := 0.25
		if abs(velocity.x) < _vel_clamp:
			velocity.x = 0
		if abs(velocity.z) < _vel_clamp:
			velocity.z = 0
	
	# Move
	var moving = move_and_slide_with_snap(velocity, _snap, Vector3.UP, ground_condition, 4, FLOOR_MAX_ANGLE)
	if is_on_wall():
		velocity = moving
	else:
		velocity.y = moving.y
	

func fly(delta: float) -> void:
		#FUNÇÕES PARA PODER SUBIR ESCADA
	direction = Vector3()
	var speed = 10
	var jump = 40
	
	full_contact = ground_check.is_colliding()
	
	if not is_on_floor():
		gravity_vec += Vector3.DOWN * gravity * delta
		h_acceleration = air_acceleration
	elif is_on_floor() and full_contact:
		gravity_vec = -get_floor_normal() * gravity
		h_acceleration = normal_acceleration
	else:
		gravity_vec = -get_floor_normal()
		h_acceleration = normal_acceleration
		
	if Input.is_action_just_pressed("space") and (is_on_floor() or ground_check.is_colliding()) and can_move and climbing == false:
		gravity_vec = Vector3.UP * jump
	
	
	if Input.is_action_pressed("w") and can_move and climbing == false:
		direction -= transform.basis.z
	
	elif Input.is_action_pressed("w") and can_move and climbing == true:
		gravity_vec = Vector3.UP * 20
	
	elif Input.is_action_pressed("s") and can_move and climbing == false:
		direction += transform.basis.z
	
	elif Input.is_action_pressed("s") and can_move and climbing == true:
		gravity_vec = Vector3.DOWN * 20
	
	if Input.is_action_pressed("a") and can_move:
		direction -= transform.basis.x
	
	elif Input.is_action_pressed("d") and can_move:
		direction += transform.basis.x
	

	if Input.is_action_pressed("shift") and can_move and can_run:
		speed = 50
		camsR = 1
		jump = 60
	else:
		speed = 10
		camsR = 0
		jump = 40
	
	direction = direction.normalized()
	h_velocity = h_velocity.linear_interpolate(direction * speed, h_acceleration * delta)
	movement.z = h_velocity.z + gravity_vec.z
	movement.x = h_velocity.x + gravity_vec.x
	movement.y = gravity_vec.y
	
	move_and_slide(movement, Vector3.UP)
	


func can_sprint() -> bool:
	return (sprint_enabled and is_on_floor())


func _input(event):
	if event is InputEventMouseMotion and can_move:
		rotate_y(deg2rad(-event.relative.x * mouse_sensitivity))
		head.rotate_x(deg2rad(-event.relative.y * mouse_sensitivity))
		head.rotation.x = clamp(head.rotation.x, deg2rad(-60), deg2rad(90))

#--------------------menu in_game---------------------------#

func _process(_delta):
	
	if has_Pa:
		$Head/PaCast.enabled = true
	else:
		$Head/PaCast.enabled = false
	
	if has_binas:
		pass
	
	if $Head/PaCast.is_colliding():
		if Input.is_action_just_pressed("m1"):
			var target = $Head/PaCast.get_collider()
			if target.is_in_group("AreaGarrafa") and desenterrar < 3 and !$Head/Pa/AnimationPlayer.is_playing() and can_move:
				var garrafa = target.get_child(1)
				garrafa.translation.y += 1.50
				desenterrar += 1
				$Head/Pa/AnimationPlayer.play("dig")
				$Head/Pa/shovelW.play()
			elif target.is_in_group("Terrain") and !$Head/Pa/AnimationPlayer.is_playing():
				var b = b_decal.instance()
				$Head/PaCast.get_collider().add_child(b)
				b.global_transform.origin = $Head/PaCast.get_collision_point()
				b.look_at($Head/PaCast.get_collision_point() + $Head/PaCast.get_collision_normal(), Vector3.RIGHT)
				$Head/Pa/AnimationPlayer.play("dig")
				$Head/Pa/shovelC.play()
			if desenterrar == 3 :
				emit_signal("desenterrado", $Head/PaCast.get_collider())
	
	if can_move:
		move_axis.x = Input.get_action_strength("w") - Input.get_action_strength("s")
		move_axis.y = Input.get_action_strength("d") - Input.get_action_strength("a")
	
	can_press_esc = can_move
	
	if Input.is_action_just_pressed("ui_cancel") and !$Menu_Domum.visible and can_press_esc:
		can_move=false
		can_press_e=false
		can_shake = false
		$SpriteControler.visible = false
		$Menu_Domum/AnimationPlayer.play("fadein")
		$Menu_Domum.visible = true
		$Menu_Domum/menus.visible = false
#		$Vfx.visible = false
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		$"Menu_Domum/botões/Continuar".grab_focus()

	if Input.is_action_just_pressed("ui_cancel") and $Menu_Domum.visible and !$Menu_Domum/AnimationPlayer.is_playing():
		can_move=true
		can_press_e=true
		can_shake = true
		$SpriteControler.visible = true
		$Menu_Domum/AnimationPlayer.play("fadeout")
		yield(get_tree().create_timer(.5), "timeout")
		$Menu_Domum.visible = false
#		$Vfx.visible = true
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _on_Continuar_pressed():
	can_move=true
	can_shake = true
	$Menu_Domum/AnimationPlayer.play("fadeout")
	yield(get_tree().create_timer(.5), "timeout")
	$Menu_Domum.visible = false
#	$Vfx.visible = true
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _on_MenuPrincipal_pressed():
	$Menu_Domum/menus/Menu/AnimationPlayer.play("fadein")
	
	$Menu_Domum/menus.visible = true
	$"Menu_Domum/menus/MenuOpções".visible = false
	$Menu_Domum/menus/Menu.visible = true
	$Menu_Domum/menus/Desktop.visible = false
	
	$"Menu_Domum/menus/Menu/borda/não".grab_focus()

func _on_sim_pressed():
	$Menu_Domum/AnimationPlayer.play("fademenu")
	yield(get_tree().create_timer(1), "timeout")
	if get_tree().change_scene("res://Menu/Scenes/Menu.tscn") != OK:
		print ("An unexpected error occured when trying to switch to the Readme scene")

func _on_no_pressed():
	$Menu_Domum/menus/Menu/AnimationPlayer.play("fadeout")
	yield(get_tree().create_timer(.5), "timeout")
	$Menu_Domum/menus.visible = false
	$"Menu_Domum/botões/Continuar".grab_focus()

#------------------------------------------------------------------#

func _on_Desktop_pressed():
	$Menu_Domum/menus/Desktop/AnimationPlayer.play("fadein")
	
	$Menu_Domum/menus.visible = true
	$"Menu_Domum/menus/MenuOpções".visible = false
	$Menu_Domum/menus/Menu.visible = false
	$Menu_Domum/menus/Desktop.visible = true
	
	$"Menu_Domum/menus/Desktop/borda/não2".grab_focus()

func _on_sim2_pressed():
	$Menu_Domum/AnimationPlayer.play("fadedesktop")
	yield(get_tree().create_timer(1), "timeout")
	get_tree().quit()

func _on_no2_pressed():
	$Menu_Domum/menus/Desktop/AnimationPlayer.play("fadeout")
	yield(get_tree().create_timer(.5), "timeout")
	$Menu_Domum/menus.visible = false
	$"Menu_Domum/botões/Continuar".grab_focus()

#------------------------------------------------------------------#

func _on_Opes_pressed():
	$"Menu_Domum/menus/MenuOpções/AnimationPlayer".play("fade")
	
	$Menu_Domum/menus.visible = true
	$Menu_Domum/menus/Menu.visible = false
	$Menu_Domum/menus/Desktop.visible = false
	$"Menu_Domum/menus/MenuOpções".visible = true


#----------------------------Climb changes-------------------------#

func _on_ClimbArea_body_entered(body:KinematicBody):
	if body:
		climbing = true
		gravity = 0
		print(climbing)


func _on_ClimbArea_body_exited(body:KinematicBody):
	if body:
		climbing = false
		gravity = 35
		print(climbing)
