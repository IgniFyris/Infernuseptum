extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		body.is_in_slime = true
		body.speed = 1.5

func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		body.is_in_slime = false
		body.speed = 5.8
