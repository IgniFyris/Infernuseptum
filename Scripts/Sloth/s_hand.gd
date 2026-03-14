extends Area2D

@export var AnimPlayer : AnimationPlayer

@onready var GrabTimer = $GrabTimer
@onready var StayDownTimer = $StayDownTimer
@onready var Hand = $Sprite2D

var DeathScene = "uid://br7ao02pl5e7w"
var rng = RandomNumberGenerator.new()

var GrabTime = rng.randi_range(3, 6)
var StayDownTime = rng.randi_range(2, 6)

func _ready() -> void:
	Hand.region_rect = Rect2(982.89, 223.88, 250.0, 270.0)
	StayDownTimer.wait_time = StayDownTime
	StayDownTimer.start()
	
func _on_body_entered(body: Node2D) -> void:
	if body is SPlayer:
		body.dead = true
		body.PlayerAnim.stop()
		body.PlayerAnim.play("death")
		SceneLoader.load_scene(DeathScene)

func _on_grab_timer_timeout() -> void:
	AnimPlayer.play_backwards("grab_upwards")
	await AnimPlayer.animation_finished
	StayDownTime = rng.randi_range(2, 6)
	StayDownTimer.start()

func _on_stay_down_timer_timeout() -> void:
	AnimPlayer.play("grab_upwards")
	await AnimPlayer.animation_finished
	GrabTimer.wait_time = GrabTime
	GrabTimer.start()
