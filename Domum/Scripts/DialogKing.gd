extends Control

export var dialogPath = ""
export(float) var textSpeed = 0.04

var dialog

var phraseNum = 0
var finished = false

func _ready():
	$Timer.wait_time = textSpeed
	_defineDialogPathKing(GlobalGroundCondition.kingDialog)
	assert(dialog, "Dialog not found")

func _getDialog() -> Array:
	var f = File.new()
	assert(f.file_exists(dialogPath), "File path does not exist")
	
	f.open(dialogPath, File.READ)
	var json = f.get_as_text()
	
	var output = parse_json(json)
	
	if typeof(output) == TYPE_ARRAY:
		return output
	else:
		return []

func _process(_delta):
	$Crown.visible = finished
	if $Crown.visible:
		$Crown/AnimationPlayer.play("CrownUP")
	
	if Input.is_action_just_pressed("r") and get_node("..")._getBodyState() and get_node("../../Player").can_press_r:
		if finished:
			_nextPhraseKing()
			$sfx_r.play()
		else:
			$Text.visible_characters = len($Text.text)
			$sfx_r.play()
	if Input.is_action_just_pressed("space") and get_node("..")._getBodyState() and get_node("../../Player").can_press_r:
		if finished:
			_dialog_end()
			$sfx_space.play()

func _nextPhraseKing():
	get_node("../StaticBody/Rei/AnimationPlayer").play("Falando")  
	
	$Back/AnimationPlayer.play("FadeIn")
	
	if phraseNum >= len(dialog):
		_dialog_end()
		return
	
	finished = false
	get_node("..").dialog_is_finished = false
	
	$Name.bbcode_text = dialog[phraseNum]["Name"]
	$Text.bbcode_text = dialog[phraseNum]["Text"]
	
	if $Name.bbcode_text == "Aren Corvam":
		$AnimationPic.play("ArenIn")
		$Picture.modulate = Color(0.39,0.39,0.39,1)
		$ProtaSprite.modulate = Color(1,1,1,1)
		$dialogKing.visible = false
		$dialogAren.visible = true
		$Name.rect_position = Vector2(152, 744)
	
	if $Name.bbcode_text == "Rei Aldrich Corvam":
		$AnimationPic.play("ArenOut")
		$Picture.modulate = Color(1,1,1,1)
		$ProtaSprite.modulate = Color(0.39,0.39,0.39,1)
		$dialogKing.visible = true
		$dialogAren.visible = false
		$Name.rect_position = Vector2(1360, 744)
	
	
	$Text.visible_characters = 0
	
	while $Text.visible_characters < len($Text.text):
		$Text.visible_characters += 1
		
		$Timer.start()
		yield($Timer, "timeout")
	
	finished = true
	phraseNum += 1
	return

func _dialog_end():
	get_node("../StaticBody/Rei/AnimationPlayer").play("Idle")
	$sfx_space.play()
	$Back/AnimationPlayer.play("FadeOut")
	$Back.visible = false
	phraseNum = 0
	visible = false
	get_node("../../Player").can_press_r = false
	get_node("../../Player").can_move = true
	get_node("../../Player").can_press_e = true
#	get_node("../Press").visible = true
#	get_node("../coroa").visible = true
	if GlobalGroundCondition.kingDialog == 1:
		get_node("../../DialogLightAreas/DialogLight")._setDialogLightText("Para andar, use [WASD]. Para entrar em um diálogo, pressione [E]. Para avança a fala, pressione [R]. Para interagir com objetos, pressione [F]!", 8)
	
	get_node("..").dialog_is_finished = true
	GlobalGroundCondition.kingDialog = 2
	_defineDialogPathKing(GlobalGroundCondition.kingDialog)


func _defineDialogPathKing(dialogPathKing):
	if dialogPathKing == 1:
		dialogPath = "res://Domum/DialogText/DialogKingText - part 1.json"
		dialog = _getDialog()
	elif dialogPathKing == 2:
		dialogPath = "res://Domum/DialogText/DialogKingText - part 2.json"
		dialog = _getDialog()
