extends Control

export var dialogPath = ""
export(float) var textSpeed = 0.04

var dialog

var phraseNum = 0
var finished = false

func _ready():
	$Timer.wait_time = textSpeed
	_defineDialogPathRed(GlobalGroundCondition.redDialog)
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
			_nextPhraseRed()
			$sfx_r.play()
		else:
			$Text.visible_characters = len($Text.text)
			$sfx_r.play()
	if Input.is_action_just_pressed("space") and get_node("..")._getBodyState() and get_node("../../Player").can_press_r:
		if finished:
			_dialog_end()
			$sfx_space.play()

func _nextPhraseRed():
	get_node("../StaticBody/Vermelho/AnimationPlayer").play("Falando") 
	
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
		$dialogAren.visible = true
		$dialogRed.visible = false
		$Name.rect_position = Vector2(152, 744)
	
	if $Name.bbcode_text == "Izuna Yamaguchi":
		$AnimationPic.play("ArenOut")
		$Picture.modulate = Color(1,1,1,1)
		$ProtaSprite.modulate = Color(0.39,0.39,0.39,1)
		$dialogRed.visible = true
		$dialogAren.visible = false
		$Name.rect_position = Vector2(1390, 744)
	
	
	$Text.visible_characters = 0
	
	while $Text.visible_characters < len($Text.text):
		$Text.visible_characters += 1
		
		$Timer.start()
		yield($Timer, "timeout")
	
	finished = true
	phraseNum += 1
	return

func _dialog_end():
	get_node("../StaticBody/Vermelho/AnimationPlayer").play("Idle") 
	$sfx_space.play()
	$Back/AnimationPlayer.play("FadeOut")
	$Back.visible = false
	phraseNum = 0
	visible = false
	get_node("../../Player").can_press_r = false
	get_node("../../Player").can_move = true
	get_node("../../Player").can_press_e = true
#	get_node("../Press").visible = true
#	get_node("../borda").visible = true
	if(GlobalGroundCondition.redDialog == 1):
		GlobalGroundCondition.allowTriggerRed = true
	if(GlobalGroundCondition.redDialog == 2):
		get_node("../../StoneWIN/StoneAnimation").play("REDStoneFade")
		get_node("../../StoneWIN/REDStoneWIN").visible = true
		get_node("../../Player").can_move = false
		get_node("../../Player").can_press_e = false
		yield(get_tree().create_timer(8), "timeout")
		get_node("../../Player").can_move = true
		get_node("../../Player").can_press_e = true
		get_node("../../StoneWIN/REDStoneWIN").visible = false
		get_node("..").dialog_is_finished = true
		get_node("../../Player/HUDStones/HUDAnimationStones").play("HUDREDStoneFade")
		get_node("../../Player/HUDStones/HUDREDStone").visible = true
		GlobalGroundCondition.stonesCount += 1
		GlobalGroundCondition.redDialog = 3
		GlobalGroundCondition.showRedStone = true
		GlobalGroundCondition.allowTriggerRed = false
		_defineDialogPathRed(GlobalGroundCondition.redDialog)
		if GlobalGroundCondition.stonesCount == 3:
			get_node("../../DialogLightAreas/DialogLight")._setDialogLightText("Aren, mal posso acreditar... CONSEGUIMOS OS TRÊS FRAGMENTOS! Agora, VOLTE ATÉ A ESTÁTUA DO FUNDADOR", 6)
			get_node("../../EndTrigger/CollisionShape").disabled = false
			get_node("../../NPCVelho/StaticBody/Area/CollisionShape").disabled = true

func _defineDialogPathRed(dialogPathRed):
	if dialogPathRed == 1:
		dialogPath = "res://Domum/DialogText/DialogRedText - part 1.json"
		dialog = _getDialog()
	elif dialogPathRed == 2:
		dialogPath = "res://Domum/DialogText/DialogRedText - part 2.json"
		GlobalGroundCondition.allowTriggerRed = false
		dialog = _getDialog()
	elif dialogPathRed == 3:
		dialogPath = "res://Domum/DialogText/DialogRedText - part 3.json"
		GlobalGroundCondition.allowTriggerRed = false
		dialog = _getDialog()
