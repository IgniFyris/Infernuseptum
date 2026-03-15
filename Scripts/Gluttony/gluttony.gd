extends Node2D

@onready var MusicPlayer = $AudioStreamPlayer2D

func _ready() -> void:
	MusicPlayer.play()

func _on_audio_stream_player_2d_finished() -> void:
	MusicPlayer.play()
