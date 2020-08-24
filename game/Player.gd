extends KinematicBody2D

const ACCELERATION = 512
const MAX_WALK_SPEED = 80
const MAX_RUN_SPEED = 130
const FRICTION = 0.2
const AIR_RESISTENCE = 0.02
const GRAVITY = 500
const JUMP_FORCE = 220

var motion = Vector2.ZERO
var is_paused = false

onready var sprite = $Sprite
onready var animationPlayer = $AnimationPlayer
onready var sfxJump = $SfxJump
onready var sfxRun = $SfxRun
onready var sfxGem = $SfxGem
onready var sfxKey = $SfxKey

func _physics_process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().change_scene(ProjectSettings.get_setting("application/run/main_scene"))
	if is_paused:
		return
		
	if Input.is_action_just_pressed("player_reset"):
		get_tree().reload_current_scene()
	
	var x_input = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	var run = Input.is_action_pressed("player_run")
	var max_speed = MAX_RUN_SPEED if run else MAX_WALK_SPEED
	sfxRun.set_pitch_scale(1.2 if run else 1.0)
	if x_input != 0:
		animationPlayer.play("Run")
		motion.x += x_input * ACCELERATION * delta
		motion.x = clamp(motion.x, -max_speed, max_speed)
		sprite.flip_h = x_input < 0
	else:
		animationPlayer.play("Stand")
	
	motion.y += GRAVITY * delta
	
	if is_on_floor():
		if x_input == 0:
			motion.x = lerp(motion.x, 0, FRICTION)
			sfxRun.stop()
		elif !sfxRun.playing:
			sfxRun.play()
		if Input.is_action_just_pressed("player_jump"):
			motion.y = -JUMP_FORCE
			sfxRun.stop()
			sfxJump.play()
	else:
		sfxRun.stop()
		animationPlayer.play("Jump")
		if Input.is_action_just_released("player_jump") and motion.y < -JUMP_FORCE/2:
			motion.y = -JUMP_FORCE/2
		if x_input == 0:
			motion.x = lerp(motion.x, 0, AIR_RESISTENCE)
	
	motion = move_and_slide(motion, Vector2.UP)

func exit_level(nextLevel):
	is_paused = true
	animationPlayer.play("Exit")
	yield(get_tree().create_timer(1.5), "timeout")
	animationPlayer.play("Stand")
	get_tree().change_scene(nextLevel)
	is_paused = false

const PASS_THROUGH_RED = 13
const PASS_THROUGH_GREEN = 11
const PASS_THROUGH_BLUE = 7

func collect_gem(modulate):
	set_modulate(modulate)
	var pitch_change = modulate.r * 0.1 + modulate.g * 0.2 + modulate.b * 0.3
	sfxGem.set_pitch_scale(0.8 + pitch_change)
	sfxGem.play()
	BackgroundMusic.change_pitch(1.0 + pitch_change)
	if modulate == Color(1,0,0):
		set_collision_layer(PASS_THROUGH_RED)
	elif modulate == Color(0,1,0):
		set_collision_layer(PASS_THROUGH_GREEN)
	elif modulate == Color(0,0,1):
		set_collision_layer(PASS_THROUGH_BLUE)

func collect_key():
	sfxKey.play()
