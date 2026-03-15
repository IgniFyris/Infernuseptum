extends Area2D

@export var DeathScene = "uid://br7ao02pl5e7w"

func _on_body_entered(body: Node2D) -> void:
	if body is GLPlayer:
		body.dead = true
		body.GLPlayerAnim.play("death")
		SceneLoader.load_scene(DeathScene)
