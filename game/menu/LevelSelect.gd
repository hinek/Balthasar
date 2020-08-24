extends Control

func _ready():
	for button in $Menu/CenterRow/VBoxContainer/ButtonGrid.get_children():
		initialize_button(button)
	$Menu/CenterRow/VBoxContainer/ButtonGrid/Lvl01.grab_focus()

func _input(event):
	if event.is_action_released("ui_cancel"):
		get_tree().change_scene("res://menu/TitleScreen.tscn")

func initialize_button(button):
	var levelNo = button.text
	button.set_disabled(int(levelNo) > Settings.level_progress)
	if levelNo.length() < 2:
		levelNo = str("0", levelNo)
	button.connect("pressed", self, "level_button_pressed", [levelNo])

func level_button_pressed(levelNo):
	get_tree().change_scene(str("res://levels/Level", levelNo, ".tscn"))
