extends Node2D

func _ready():
	BackgroundMusic.stop()

func _on_AnimationPlayer_animation_finished(anim_name):
	BackgroundMusic.play()
	get_tree().change_scene("res://levels/Level01.tscn")
