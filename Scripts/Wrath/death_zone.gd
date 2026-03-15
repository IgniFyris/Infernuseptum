extends Area2D

@onready var DeathScene = "uid://br7ao02pl5e7w"

func _on_body_entered(body: Node2D) -> void:
	if body is WPlayer:
		body.dead = true
		body.WPlayerAnim.play("death")
		SceneLoader.load_scene(DeathScene)
