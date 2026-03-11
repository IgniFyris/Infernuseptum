extends Sprite2D

var frequency = 2.0
var amplitude = 10.0
var time = 0.0

func _process(delta):
	time += delta

	rotation_degrees = sin(time * frequency) * 5
	position.y += cos(time * frequency * 2) * 40 * delta 
