extends Area2D

func _process(_delta: float) -> void:
	self.rotation_degrees += 1
	if self.position.y < 758:
		self.position.y += 3
	else:
		queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body is PPlayer:
		body.life -= 1
		queue_free()
