extends Node

const settings_file = "user://settings.save"

var enable_bgm = true setget set_enable_bgm
var enable_sfx = true setget set_enable_sfx
var level_progress = 1 setget set_level_progress

func _ready():
	load_settings()
	BackgroundMusic.set_bgm_enabled(Settings.enable_bgm)
	BackgroundMusic.set_sfx_enabled(Settings.enable_sfx)
	BackgroundMusic.play()
	pass # Replace with function body.

func set_enable_bgm(value):
	enable_bgm = value
	BackgroundMusic.set_bgm_enabled(enable_bgm)
	save_settings()

func set_enable_sfx(value):
	enable_sfx = value
	BackgroundMusic.set_sfx_enabled(enable_sfx)
	save_settings()

func set_level_progress(value):
	level_progress = value
	save_settings()

func save_settings():
	var f = File.new()
	f.open(settings_file, File.WRITE)
	f.store_var(enable_bgm)
	f.store_var(enable_sfx)
	f.store_var(level_progress)
	f.close()

func load_settings():
	var f = File.new()
	if f.file_exists(settings_file):
		f.open(settings_file, File.READ)
		enable_bgm = f.get_var()
		enable_sfx = f.get_var()
		level_progress = f.get_var()
		f.close()
