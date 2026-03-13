extends CanvasLayer

func _ready() -> void:
	hide()

func _on_player_sloth_death() -> void:
	show()
