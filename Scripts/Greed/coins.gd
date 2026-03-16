extends Area2D

@onready var Coin = $AudioStreamPlayer2D

func _on_body_entered(body: Node2D) -> void:
	if body is GPlayer:
		if body.coins != 3:
			Coin.play()
			body.coins += 1
			queue_free()
