extends Button

export var button_text = "Label"
export(String, FILE, "*.tscn") var scene_to_load

func _ready():
	$Label.set_text(button_text)

func _on_Button_pressed():
	get_tree().change_scene(scene_to_load)
