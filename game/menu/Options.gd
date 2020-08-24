extends Control

func _ready():
	refresh_icon_frames()
	$Menu/CenterRow/Buttons/ToggleMusic.grab_focus()

func _input(event):
	if event.is_action_released("ui_cancel"):
		get_tree().change_scene("res://menu/TitleScreen.tscn")

func _on_ToggleMusic_pressed():
	Settings.enable_bgm = !Settings.enable_bgm
	refresh_icon_frames()

func _on_ToggleSfx_pressed():
	Settings.enable_sfx = !Settings.enable_sfx
	refresh_icon_frames()

func refresh_icon_frames():
	$Menu/CenterRow/Buttons/ToggleMusic/Icon.set_frame(806 if Settings.enable_bgm else 805)
	$Menu/CenterRow/Buttons/ToggleSfx/Icon.set_frame(806 if Settings.enable_sfx else 805)	
