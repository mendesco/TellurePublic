extends Spatial


var checkpoint = Vector3()
var chk_count = 0

var redActvated = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	
	checkpoint = get_node("../Player").translation
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area_body_entered(body):
	if body.is_in_group("Player"):
		get_node("../Player/Death").visible = true
		get_node("../Player/Death/AnimationPlayer").play("fade")
		yield(get_tree().create_timer(1), "timeout")
		get_node("../Player").translation = checkpoint
		get_node("../Player/Death/AnimationPlayer").play_backwards("fade")
		yield(get_tree().create_timer(1), "timeout")
		get_node("../Player/Death").visible = false


func _on_PilarAtivador_active():
	$BluePlatforms1/AnimationPlayer.play("active")


func _on_PilarAtivador2_active():
	$BluePlataform/AnimationPlayer.play("active")


func _on_CheckPointArea_body_entered(body):
	if body.is_in_group("Player"):
		print("entrei no checkpoint 1")
		checkpoint = get_node("../Player").translation


func _on_AreaAtivaoAuto_body_entered(body):
	if body.is_in_group("Player") and redActvated == 0:
		redActvated = 1
		$"RedPlatforms pt1/AnimationPlayer".play("platUP")
		yield($"RedPlatforms pt1/AnimationPlayer", "animation_finished")
		$"RedPlatforms pt1/AnimationPlayer".play("move")


func _on_CheckPointArea3_body_entered(body):
	if body.is_in_group("Player"):
		print("entrei no checkpoint 3")
		checkpoint = get_node("../Player").translation


func _on_CheckPointArea2_body_entered(body):
	if body.is_in_group("Player"):
		print("entrei no checkpoint 2")
		checkpoint = get_node("../Player").translation
