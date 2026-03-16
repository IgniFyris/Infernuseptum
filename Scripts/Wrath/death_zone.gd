extends Area2D

@onready var DeathScene = "uid://br7ao02pl5e7w"

@onready var sizzle = $AudioStreamPlayer2D

func _on_body_entered(body: Node2D) -> void:
	if body is WPlayer:
		body.dead = true
		sizzle.play()
		body.WPlayerAnim.play("death")
		
		await sizzle.finished
		
		SceneLoader.load_scene(DeathScene)
