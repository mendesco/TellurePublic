extends Spatial

var can_open_chest = false
var want_open_chest = false

func _ready():
	get_node("Lanterna1/OmniLight").visible = false
	get_node("Lanterna2/OmniLight2").visible = false

func _process(_delta):
	if get_node("Lanterna1/OmniLight").visible == true && get_node("Lanterna2/OmniLight2").visible == true:
		get_node("InteractArea/InteractAreaCollision").disabled = false
		can_open_chest = true
	if Input.is_action_just_pressed("f") and can_open_chest and want_open_chest and get_node("../../Player").can_press_f:
		GlobalGroundCondition.redDialog = 2
		GlobalGroundCondition.comeBackRed = true
		GlobalGroundCondition.comeBackGreen = false
		GlobalGroundCondition.comeBackBlue = false
		$sfx.play()
		get_node("../../Audio/music").play()
		get_node("../../Audio/music/Tween").interpolate_property(get_node("../../Audio/music"), "volume_db", get_node("../../Audio/music").volume_db, -80, 1, Tween.TRANS_LINEAR, Tween.EASE_IN)
		get_node("../../Audio/music/Tween").start()
		
		get_node("../../Audio/backsfx").play()
		get_node("../../Audio/backsfx/Tween").interpolate_property(get_node("../../Audio/backsfx"), "volume_db", get_node("../../Audio/backsfx").volume_db, -80, 1, Tween.TRANS_LINEAR, Tween.EASE_IN)
		get_node("../../Audio/backsfx/Tween").start()
#		get_node("../../Player/Death").visible = true
#		get_node("../../Player/Death/AnimationPlayer").play_backwards("fade")
		yield(get_tree().create_timer(1), "timeout")
		LoadingScreen.load_level("domum")


func _on_InteractArea_body_entered(body):
	if body.is_in_group("Player"):
		get_node("../../Player/SpriteControler/Interagir").visible = true
		get_node("../../Player/SpriteControler/Interagir/AnimationPlayer").play("fadein")
		get_node("../../Player").can_press_f = true
		want_open_chest = true



func _on_InteractArea_body_exited(body):
	if body.is_in_group("Player"):
		get_node("../../Player/SpriteControler/Interagir/AnimationPlayer").play_backwards("fadein")
		get_node("../../Player").can_press_f = false
		want_open_chest = false
