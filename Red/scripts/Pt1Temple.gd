extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Spatial5/AnimationPlayer.play_backwards("move")
	$Spatial2/AnimationPlayer.play_backwards("move")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area_body_entered(body):
	if body.is_in_group("Player"):
		$AnimationPlayer.play("move")


func _on_BauAtivador_activateChest():
	get_node("AnimationPlayer").play("WhenActivated")
	get_node("../ChestArea/Lanterna1/OmniLight").visible = true
