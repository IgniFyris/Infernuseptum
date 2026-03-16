extends Area2D

@onready var acid = $AudioStreamPlayer2D

func _on_body_entered(body: Node2D) -> void:
	if body is PPlayer:
		acid.play()
