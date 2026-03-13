extends Area2D

var SlothScene = "uid://dagyj4t8j84c4"
var GreedScene = "uid://bv7herqgc7fnv"

func _on_body_entered(body: Node2D) -> void:
	if body is Player && SceneLoader.scene_path == SlothScene:
		SceneLoader.load_scene(GreedScene)
