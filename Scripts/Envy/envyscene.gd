extends Node2D

@onready var TimeUntilOpenTimer = $TimeUntilOpenTimer
@onready var TimeUntilCloseTimer = $TimeUntilCloseTimer
@onready var BGC = $BG/Background_Closed
@onready var BGH = $BG/Background_Half
@onready var BGO = $BG/Background_Open

@export var EyeOpenAnim : AnimationPlayer

@onready var Beep = $dundun

var rng = RandomNumberGenerator.new()

var TimeUntilOpen = rng.randf_range(4, 7)
var TimeUntilClose

@onready var MusicPlayer = $AudioStreamPlayer2D

func _on_audio_stream_player_2d_finished() -> void:
	MusicPlayer.play()

func _ready() -> void:
	MusicPlayer.play()
	BGC.visible = true
	BGH.visible = false
	BGO.visible = false
	TimeUntilOpenTimer.wait_time = 6.8
	
	TimeUntilOpenTimer.start()

func _on_time_until_close_timer_timeout() -> void:
	EyeOpenAnim.play("close")
	
	await EyeOpenAnim.animation_finished
	
	BGC.visible = true
	BGO.visible = false
	
	TimeUntilOpen = rng.randf_range(4, 7)
	TimeUntilOpenTimer.wait_time = TimeUntilOpen
	TimeUntilOpenTimer.start()

func _on_time_until_open_timer_timeout() -> void:
	EyeOpenAnim.play("open")
	Beep.play()
	
	await EyeOpenAnim.animation_finished
	
	BGC.visible = false
	BGO.visible = true
	
	TimeUntilClose = rng.randf_range(4, 7)
	TimeUntilCloseTimer.wait_time = TimeUntilClose
	TimeUntilCloseTimer.start()
