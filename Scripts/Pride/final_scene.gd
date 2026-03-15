extends Node2D

@onready var Button1 = $Yes
@onready var Button2 = $No

@export var GoodEnd : String = &""
@export var BadEnd : String = &""

func _on_texture_button_pressed() -> void:
	Button1.disabled = true
	Button2.disabled = true
	SceneLoader.load_scene(BadEnd)

func _on_texture_button_2_pressed() -> void:
	Button1.disabled = true
	Button2.disabled = true
	SceneLoader.load_scene(GoodEnd)
