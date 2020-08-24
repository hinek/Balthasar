extends Area2D

const SWITCH_OFF_FRAME = 483
const SWITCH_ON_FRAME = 484

export var switch_state = false setget set_switch_state

signal switch_toggled(switch_is_on)

func _ready():
	pass

func _process(delta):
	if Input.is_action_just_pressed("player_use_switch"):
		var bodies = get_overlapping_bodies()
		for body in bodies:
			if body.name == "Player":
				set_switch_state(!switch_state)

func set_switch_state(value):
	switch_state = value
	$Sprite.set_frame(SWITCH_ON_FRAME if switch_state else SWITCH_OFF_FRAME)
	emit_signal("switch_toggled", switch_state)
