extends Area2D

const OPEN_DOOR_FRAME = 540
const CLOSED_DOOR_FRAME = 541

export(String, FILE, "*.tscn") var next_scene
export(bool) var door_open

onready var sprite = $Sprite

func _ready():
	sprite.set_frame(OPEN_DOOR_FRAME if door_open else CLOSED_DOOR_FRAME)

func _on_Exit_body_entered(body):
	if body.get_name() == "Player" && door_open:
		BackgroundMusic.change_pitch(1.0)
		var level_number = get_level_number_from_scene(next_scene)
		if (level_number > Settings.level_progress):
			Settings.level_progress = level_number
		var player = get_tree().get_current_scene().get_node("Player")
		player.exit_level(next_scene)

func unlock():
	door_open = true
	sprite.set_frame(OPEN_DOOR_FRAME if door_open else CLOSED_DOOR_FRAME)

func get_level_number_from_scene(scene):
	var regex = RegEx.new()
	regex.compile("(\\d+).tscn$")
	var result = regex.search(scene)
	if result != null:
		return int(result.get_string(1))
	else:
		return -1
