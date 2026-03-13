extends CanvasLayer

func _ready() -> void:
	hide()

func _on_player_sloth_death() -> void:
	show()

func _on_sloth_amalgamation_sloth_amalgamation_death() -> void:
	show()
