extends Node2D

@export var Anim : AnimationPlayer
@onready var TimeToStartTimer = $TimeToStart
var rng = RandomNumberGenerator.new()

func _ready() -> void:
	randomize()
	var TimeToStart = rng.randf()
	TimeToStartTimer.wait_time = TimeToStart
	TimeToStartTimer.start()

func _on_time_to_start_timeout() -> void:
	Anim.play("move")
