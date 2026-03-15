extends Node2D

@onready var ButtonCreationTimer = $ButtonCreationTimer
@onready var A2 = $BG2s
@onready var A3 = $BG3s

var SucButton: PackedScene = preload("uid://46517ff8fmhw")

var total_buttons_made = 0
var button_has_been_made = false

func _ready() -> void:
	self.position = Vector2(0.0, 0.0)
	ButtonCreationTimer.start()

func _process(_delta: float) -> void:
	if (total_buttons_made < 20 and ButtonCreationTimer.is_stopped()):
		var new_button = SucButton.instantiate()
		add_child(new_button)
		total_buttons_made += 1
		ButtonCreationTimer.start()
		new_button.z_index = 100
		button_has_been_made = true
	elif total_buttons_made == 20:
		queue_free()
		
	if total_buttons_made == 7:
		create_tween().tween_property(A2, "modulate:a", 1, 2)
	elif total_buttons_made == 14:
		create_tween().tween_property(A3, "modulate:a", 1, 2)
