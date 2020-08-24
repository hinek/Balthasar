extends Area2D

func _on_ColorGem_body_entered(body):
	if body.get_name() == "Player":
		body.collect_gem(modulate)
		queue_free()
