extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		body.is_in_slime = true
		body.speed = 1.5

func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		body.is_in_slime = false
		body.speed = 7.0
