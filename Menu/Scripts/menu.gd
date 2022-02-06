extends Control

var pular = false

func _ready():
	Userdata.session_data = Userdata.default_data
	
	get_node("Menu/MenuOpções").visible = false
	get_node("Menu/Botões").visible = false
	get_node("Menu/MenuOpções/Settings"). visible = false
	get_node("Menu/Créditos").visible = false
	get_node("quit").visible = false
	get_node("Menu/Sair").visible = false
	get_node("Intro_Transition").visible = false
	get_node("Opening").visible = true

	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

	get_tree().get_root().set_disable_input(true)
	get_tree().get_root().set_disable_input(false)

	$Opening/AnimationPlayer.play("fade_out")
	yield(get_tree().create_timer(14), "timeout")
	get_node("Opening").visible = false

	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	$"Menu/Botões/AnimationPlayer".play("fade")
	get_node("Menu/Botões").visible = true
	get_node("Menu/Botões/Novo Jogo").grab_focus()

func _process(_delta):
	if Input.is_action_just_pressed("ui_cancel") and get_node("Menu/MenuOpções/Label").is_visible_in_tree():
		_on_back_Button_pressed()
	
	if Input.is_action_just_pressed("ui_cancel") and get_node("Menu/Sair").is_visible_in_tree():
		_on_no_pressed()
	
	if Input.is_action_just_pressed("ui_cancel") and get_node("Menu/Créditos").is_visible_in_tree():
		_on_VoltarCreditos_pressed()
	
	if Input.is_action_just_pressed("ui_cancel") and get_node("Menu/Botões").is_visible_in_tree() and !get_node("Menu/Créditos").is_visible_in_tree() and !get_node("Menu/Sair").is_visible_in_tree():
		_on_Sair_pressed()
	

func _on_Novo_Jogo_pressed():

	$Music/Tween.interpolate_property($Music, "volume_db", $Music.volume_db, -80, 3, Tween.TRANS_QUART, Tween.EASE_OUT)
	$Music/Tween.start()
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	$quit.visible = true
	$AnimationPlayer.play("quit")
	yield(get_tree().create_timer(1), "timeout")
	get_node("Intro_Transition").visible = true
	get_node("Intro_Transition/VideoIntroPlayer").play()
	
	$"Menu/Botões/Novo Jogo".disabled = true
	$"Menu/Botões/Opções".disabled = true
	$"Menu/Botões/Sair".disabled = true
	$"Menu/Botões/Créditos".disabled = true

func _on_VideoIntroPlayer_finished():
#	LoadingScreen.cena_corrente = ("menu")
	LoadingScreen.load_level("domum")

func _on_Opes_pressed():
	$"Menu/Botões/AnimationPlayer".play("fadeout")
	yield(get_tree().create_timer(.5), "timeout")
	$"Menu/MenuOpções/AnimationPlayer".play("fade")
	yield(get_tree().create_timer(.3), "timeout")
	
	get_node("Menu/MenuOpções").show()
	
	get_node("Menu/MenuOpções/Settings"). visible = true
	get_node("Menu/MenuOpções/Settings/List/MasterVolume").grab_focus()
	
	get_node("Menu/Botões").visible = false

func _on_back_Button_pressed():
	$"Menu/MenuOpções/AnimationPlayer".play("out")
	yield(get_tree().create_timer(.4), "timeout")
	get_node("Menu/MenuOpções").visible = false
	
	$"Menu/Botões/AnimationPlayer".play("fade")
	yield(get_tree().create_timer(.1), "timeout")
	get_node("Menu/Botões").show()
	
	get_node("Menu/Botões/Novo Jogo").grab_focus()

func _on_Crditos_pressed():
	$"Menu/Créditos/AnimationPlayer".play("fade in")
	$"Menu/Créditos".visible = true
	$"Menu/Créditos/VideoCreditos".play()
	$"Menu/Créditos/VoltarCreditos".grab_focus()

func _on_VoltarCreditos_pressed():
	$"Menu/Créditos/AnimationPlayer".play("fade out")
	yield(get_tree().create_timer(.5), "timeout")
	$"Menu/Créditos/VideoCreditos".stop()
	$"Menu/Créditos".visible = false
	$"Menu/Botões/Novo Jogo".grab_focus()

func _on_Sair_pressed():
	$Menu/Sair.visible = true
	$Menu/Sair/AnimationPlayer.play("fade in")
	$"Menu/Sair/não".grab_focus()

func _on_sim_pressed():
	$quit.visible = true
	$Music/Tween.start()
	$Music/Tween.interpolate_property($Music, "volume_db", $Music.volume_db, -40, 1, Tween.TRANS_QUART, Tween.EASE_OUT)
	$AnimationPlayer.play("quit")
	yield(get_tree().create_timer(1), "timeout")
	get_tree().quit()

func _on_no_pressed():
	$Menu/Sair/AnimationPlayer.play("fade out")
	yield(get_tree().create_timer(.5), "timeout")
	$Menu/Sair.visible = false
	$quit.visible = false
	$"Menu/Botões/Novo Jogo".grab_focus()

func _on_insta_pressed():
	OS.shell_open("https://www.instagram.com/spot_tellure/")

func _input(event):
	if event is InputEventKey and event.pressed and pular == false:
		$Intro_Transition/Pular/AnimationPular.play("fade")
		$Intro_Transition/Pular/Timer.start()
	
	if Input.is_action_just_pressed("p") and $Intro_Transition/VideoIntroPlayer.is_playing() and pular == true:
		_on_VideoIntroPlayer_finished()
	

func _on_AnimationPular_animation_finished(anim_name):
	if anim_name == "fade":
		pular = true
	if anim_name == "fade_back":
		pular = false

func _on_Timer_timeout():
	$Intro_Transition/Pular/AnimationPular.play("fade_back")
	
