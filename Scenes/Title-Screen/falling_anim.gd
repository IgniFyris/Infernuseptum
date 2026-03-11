extends Node2D

@export var animation_player : AnimationPlayer

func process(_delta):
	animation_player.play("Falling")
