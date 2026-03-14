extends Area2D

@export var AnimPlayer : AnimationPlayer

@onready var GrabTimer = $UpTimer
@onready var StayDownTimer = $DownTimer

var SuccubiScene = ""

var target_pos

func _ready() -> void:
	target_pos = self.position
	StayDownTimer.start()
	
func _on_body_entered(body: Node2D) -> void:
	if body is LPlayer:
		body.is_in_pull_range = true
		body.target_pos = target_pos

func _on_up_timer_timeout() -> void:
	AnimPlayer.play_backwards("float")
	await AnimPlayer.animation_finished
	StayDownTimer.start()

func _on_down_timer_timeout() -> void:
	AnimPlayer.play("float")
	await AnimPlayer.animation_finished
	GrabTimer.start()

func _on_body_exited(body: Node2D) -> void:
	if body is LPlayer:
		body.is_in_pull_range = false
