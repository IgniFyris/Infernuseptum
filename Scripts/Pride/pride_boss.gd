extends Node2D

@onready var ChangePosTimer = $ChangePos
@onready var UntilCreationTimer = $UntilCreationTimer
@onready var TimeToWait = $TimeToWait

var star : PackedScene = preload("res://Scenes/Pride/star.tscn") 

var positions = [Vector2(636, 153), Vector2(894, 153), Vector2(1126.8, 153), Vector2(350, 153), Vector2(176.8, 153)]
var rng = RandomNumberGenerator.new()

func _ready() -> void:
	self.position = positions[0]
	ChangePosTimer.wait_time = rng.randf_range(1, 2)
	UntilCreationTimer.wait_time = rng.randf_range(1, 2)
	ChangePosTimer.start()
	TimeToWait.start()
	
func _on_change_pos_timeout() -> void:
	create_tween().tween_property(self, "position", positions[randi_range(0, 4)], 2)

func _on_time_to_wait_timeout() -> void:
	UntilCreationTimer.start()

func _on_until_creation_timer_timeout() -> void:
	var StarScene = star.instantiate()
	get_tree().get_root().add_child(StarScene)
	StarScene.z_index = 90
	StarScene.position = self.position
	TimeToWait.start()
