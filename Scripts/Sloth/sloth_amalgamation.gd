extends Area2D

signal SlothAmalgamationDeath

var DeathScene = "uid://br7ao02pl5e7w"

func _ready() -> void:
	create_tween().tween_property(self, "position:y", 0.0, 30)

func _on_body_entered(body: Node2D) -> void:
	if body is SPlayer:
		SlothAmalgamationDeath.emit()
		SceneLoader.load_scene(DeathScene)
