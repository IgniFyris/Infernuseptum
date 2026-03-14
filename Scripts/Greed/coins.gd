extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body is GPlayer:
		if body.coins != 3:
			body.coins += 1
			queue_free()
