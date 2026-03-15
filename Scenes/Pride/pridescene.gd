extends Node2D

@onready var Portal = $Portal

func _ready() -> void:
	Portal.monitoring = false
	Portal.visible = false
