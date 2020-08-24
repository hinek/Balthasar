extends Control

func _ready():
	$Menu/CenterRow/Buttons/NewGame.grab_focus()

func _on_Exit_pressed():
	get_tree().quit()
