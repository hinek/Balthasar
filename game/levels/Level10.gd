extends Node2D

const WALL_SPEED = 10
var wall_target_position = Vector2.ZERO

func _on_Switch_switch_toggled(switch_is_on):
	wall_target_position = Vector2(0, 8 * 16 if switch_is_on else 0)

func _process(delta):
	var wall = $WallSwitchPair/Wall
	if wall.position != wall_target_position:
		wall.position.x = lerp(wall.position.x, wall_target_position.x, delta * WALL_SPEED)
		wall.position.y = lerp(wall.position.y, wall_target_position.y, delta * WALL_SPEED)
