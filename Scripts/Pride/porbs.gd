extends Area2D

@onready var UntilShowTimer = $UntilShow
@onready var UntilHideTimer = $UntilHide
var rng = RandomNumberGenerator.new()

var positions = [Vector2(57, 326), Vector2(638, 337), Vector2(431, 428), Vector2(914, 394), Vector2(1060, 330)]

func _ready() -> void:
	self.position = positions[rng.randi_range(0, 4)]
	self.visible = false
	self.monitoring = false
	var show_waitTime = rng.randf_range(12, 20)
	var hide_waitTime = rng.randf_range(10, 20)
	print(show_waitTime)
	
	UntilHideTimer.wait_time = hide_waitTime
	UntilShowTimer.wait_time = show_waitTime
	
	UntilShowTimer.start()

func _on_body_entered(body: Node2D) -> void:
	if body is PPlayer or body is OPPlayer:
		body.pride_meter += 1
		queue_free()

func _on_until_show_timeout() -> void:
	self.visible = true
	self.monitoring = true
	UntilHideTimer.start()

func _on_until_hide_timeout() -> void:
	self.visible = false
	self.monitoring = false
	UntilShowTimer.start()
