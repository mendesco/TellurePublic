extends Control

#The amount of possible values in volume slider + 1 (since zero counts as minimum);
#This will also become the max value of every slider;
const VOLUME_FRACTIONS := 50

#Attach everything to a variable;
onready var master_volume := $List/MasterVolume
onready var music_volume := $List/MusicVolume
onready var effects_volume := $List/Effects/EffectsVolume
onready var effects_test := $List/Effects/Test
onready var sfx := $SFX
#This variable will read the resolution set in settings;
onready var window : Vector2 = Userdata.get_config("window_size")

func _ready():
	$"dropdown_Resolução".add_item("Selecione")
	$"dropdown_Resolução".add_item("1920x1080")
	$"dropdown_Resolução".add_item("1600x900")
	$"dropdown_Resolução".add_item("1280x1024")
	$"dropdown_Resolução".add_item("1280x720")
	$"dropdown_Resolução".add_item("1280x960")
	$"dropdown_Resolução".add_item("1024x768")
	$"dropdown_Resolução".add_item("800x600")
	
	$"dropdown_Resolução".set_item_disabled(0, true)
	
	#Multiply volumes by 100 since slider doesn't support floats;
	master_volume.max_value = VOLUME_FRACTIONS
	master_volume.value = Userdata.get_config("volume_master") * VOLUME_FRACTIONS
	music_volume.max_value = VOLUME_FRACTIONS
	music_volume.value = Userdata.get_config("volume_music") * VOLUME_FRACTIONS
	effects_volume.max_value = VOLUME_FRACTIONS
	effects_volume.value = Userdata.get_config("volume_sfx") * VOLUME_FRACTIONS

func _on_MasterVolume_value_changed(value):
	Userdata.save_config("volume_master", value/VOLUME_FRACTIONS)

func _on_MusicVolume_value_changed(value):
	Userdata.save_config("volume_music", value/VOLUME_FRACTIONS)

func _on_EffectsVolume_value_changed(value):
	Userdata.save_config("volume_sfx", value/VOLUME_FRACTIONS)

func _on_Apply_pressed():
		Userdata.save_config("window_size", window)
		Userdata.load_config()

func _on_Test_pressed():
	sfx.play()


func _on_dropdown_Resoluo_item_selected(index):
	if index == 1:
		window = Vector2(1920, 1080)
	if index == 2:
		window = Vector2(1600, 900)
	if index == 3:
		window = Vector2(1280, 1024)
	if index == 4:
		window = Vector2(1280, 720)
	if index == 5:
		window = Vector2(1280, 960)
	if index == 6:
		window = Vector2(1024, 768)
	if index == 7:
		window = Vector2(800, 600)
