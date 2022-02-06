extends Spatial


var checkpointpt2 = Vector3()
var chk_count = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	checkpointpt2 = get_node("../Player").translation
	$AreaBackANplatR.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_CheckPointArea2_body_entered(body):
	if body.is_in_group("Player"):
		print("entrei no checkpoint 2")
		checkpointpt2 = get_node("../Player").translation


func _on_DeathArea_body_entered(body):
	if body.is_in_group("Player"):
		get_node("../Player/Death").visible = true
		get_node("../Player/Death/AnimationPlayer").play("fade")
		yield(get_tree().create_timer(1), "timeout")
		get_node("../Player").translation = checkpointpt2
		get_node("../Player/Death/AnimationPlayer").play_backwards("fade")
		yield(get_tree().create_timer(1), "timeout")
		get_node("../Player/Death").visible = false


func _on_PilarAtivador_active():
	get_node("PlatVermelha/Plata 5/AnimationPlayer").play("active")
	


func _on_PilarAtivador2_active():
	get_node("BluePF/AnimationPlayer").play("active")
	$AreaBackANplatR.visible = true


func _on_AreaANplatR_body_entered(body):
	if body.is_in_group("Player"):
		print("sarv")
		get_node("PlatVermelha/AnimationPlayer").stop()
		get_node("PlatVermelha/AnimationPlayer").play("Move")


func _on_AreaBackANplatR_body_entered(body):
	if body.is_in_group("Player"):
		print("sarv")
		get_node("PlatVermelha/AnimationPlayer").stop()
		get_node("PlatVermelha/AnimationPlayer").play_backwards("Move")


func _on_CheckPointArea3_body_entered(body):
	if body.is_in_group("Player"):
		print("entrei no checkpoint 3")
		checkpointpt2 = get_node("../Player").translation


func _on_CheckPointArea4_body_entered(body):
	if body.is_in_group("Player"):
		print("entrei no checkpoint 4")
		checkpointpt2 = get_node("../Player").translation


func _on_Checkpoint6_body_entered(body):
	if body.is_in_group("Player"):
		print("entrei no checkpoint 6")
		checkpointpt2 = get_node("../Player").translation


func _on_Checkpoint7_body_entered(body):
	if body.is_in_group("Player"):
		print("entrei no checkpoint 7")
		checkpointpt2 = get_node("../Player").translation


func _on_CheckpoitAreaPuzzle_body_entered(body):
	if body.is_in_group("Player"):
		print("entrei no checkpoint puzzle")
		checkpointpt2 = get_node("../Player").translation
