extends Area2D

@onready var TimeUntilWrathAdded = get_parent().get_node("TimeUntilWrathAdded")

var player_in_wzone = false
var player_body = null

func _process(_delta: float) -> void:
	if player_in_wzone and TimeUntilWrathAdded.is_stopped():
		TimeUntilWrathAdded.start()
		player_body.wrath_meter += 1

func _on_body_entered(body: Node2D) -> void:
	if body is WPlayer:
		player_body = body
		player_in_wzone = true
		
func _on_body_exited(body: Node2D) -> void:
	if body is WPlayer:
		player_in_wzone = false
		TimeUntilWrathAdded.stop()
