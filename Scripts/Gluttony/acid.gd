extends Area2D

@onready var bubble = $AudioStreamPlayer2D

@export var DeathScene = "uid://br7ao02pl5e7w"

func _on_body_entered(body: Node2D) -> void:
	if body is GLPlayer:
		body.dead = true
		bubble.play()
		body.GLPlayerAnim.play("death")
		
		await bubble.finished
		
		SceneLoader.load_scene(DeathScene)
