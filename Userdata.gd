extends Node

#This singleton is meant to handle all setting changes and saves;

enum BUS {MASTER, MUSIC, SFX}

const CONFIG_FILE := "user://config.cfg"

#There will be multiple save files so let's index them at extension;
const SAVE_FILE := "user://save."

#Default game settings that will be loaded and saved when no file is present;
var default_config: Dictionary = {
	#Volumes are declared in linear energy so we can use a 0-100% slider;
	#0 linear is -inf db, which doesn't support being stored as float
	#so we store an unconverted value
	"volume_master": 1.0,
	"volume_music": 1.0,
	"volume_sfx": 1.0,
	"window_size": Vector2(1920, 1080)
	#There may be another setting variables according to your needs
	#e.g. brightness level, input maps, fullscreen or windowed, etc.;
}

#Default game data that will be written on a New Game;
const default_data: Dictionary = { 
	"name": "Player",
	"balance": 91720
}

#Game data that will be active during gameplay;
#Will be changed to a save game when one is loaded;
var session_data := default_data

#Will serve both as the save slot and save file extension;
var active_slot: int

func _init():
	#Set up everything on startup;
	load_config()

#Loads saved settings;
func load_config() -> void:
	var cfg = ConfigFile.new()
	var unexistant = cfg.load(CONFIG_FILE) #Checks if the config file exists;
	if unexistant: 
		revert_config(cfg)
		#This function will be recalled by revert_config so let's end it;
		return
	#Apply all the settings to the session already;
	#Volume values are converted to decibels in set_audio();
	set_audio(BUS.MASTER, cfg.get_value("settings", "volume_master"))
	set_audio(BUS.MUSIC, cfg.get_value("settings", "volume_music"))
	set_audio(BUS.SFX, cfg.get_value("settings", "volume_sfx"))
	OS.set_window_size(cfg.get_value("settings", "window_size"))

#Called in the other functions whenever a file is not found;
func revert_config(cfg: ConfigFile):
	#Write default settings to cfg;
	for key in default_config.keys():
		cfg.set_value("settings", key, default_config[str(key)])
	cfg.save(CONFIG_FILE)
	load_config()
	return cfg

#Called whenever a setting is changed by the methods;
#The key and its value should be specified by the method in parameters;
func save_config(setting: String, value):
	var cfg = ConfigFile.new()
	var unexistant = cfg.load(CONFIG_FILE)
	#Check if the file went away during runtime;
	if unexistant: cfg = revert_config(cfg)
	cfg.set_value("settings", setting, value)
	cfg.save(CONFIG_FILE)

func get_config(setting):
	var cfg = ConfigFile.new()
	var unexistant = cfg.load(CONFIG_FILE)
	if unexistant: cfg = revert_config(cfg)
	var value = cfg.get_value("settings", setting)
	return value

func set_audio(bus, value):
	AudioServer.set_bus_volume_db(bus, linear2db(value))

#Check if the data exists and return it's name variable;
func check_data(slot: int):
	var fileslot = "%s%d" %[SAVE_FILE, slot] #Points to the file of that slot
	var file = File.new()
	if file.file_exists(fileslot):
		file.open(fileslot, File.READ)
		return file.get_var()["name"]
	else: return null
