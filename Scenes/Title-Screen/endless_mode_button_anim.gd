extends TextureButton

@onready var ComingSoon = get_parent().get_node("ComingSoon")

var frequency = 2.0
var amplitude = 10.0
var time = 0.0

func _process(delta):
	time += delta

	rotation_degrees = cos(time * frequency)
	position.x += sin(time * frequency * 2) * 20 * delta 

func _on_mouse_entered() -> void:
	ComingSoon.modulate.a = 1

func _on_mouse_exited() -> void:
	ComingSoon.modulate.a = 0
