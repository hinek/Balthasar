extends Area2D

func _ready():
	pass # Replace with function body.

func _on_Key_body_entered(body):
	if body.get_name() == "Player":
		body.collect_key()
		queue_free()

func _on_Key_tree_exiting():
	if get_parent().get_child_count() <= 1:
		var exit = get_tree().get_current_scene().get_node("Exit")
		exit.unlock()
