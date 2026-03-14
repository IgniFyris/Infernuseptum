extends Node2D

signal PressedRight

@export var DeathScene : String = &""

func _on_texture_button_pressed() -> void:
	SceneLoader.load_scene(DeathScene)

func _on_texture_button_2_pressed() -> void:
	SceneLoader.load_scene(DeathScene)

func _on_texture_button_3_pressed() -> void:
	SceneLoader.load_scene(DeathScene)

func _on_texture_button_4_pressed() -> void:
	PressedRight.emit()
	create_tween().tween_property(self, "modulate:a", 0, 1)
