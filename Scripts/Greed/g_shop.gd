extends Area2D

@onready var ShopSprite = $Sprite2D

func _ready() -> void:
	ShopSprite.texture = ResourceLoader.load("uid://et110fipe65b")

func _on_body_entered(body: Node2D) -> void:
	if body is GPlayer:
		ShopSprite.texture = ResourceLoader.load("uid://couwx6d4r4mks")

func _on_body_exited(body: Node2D) -> void:
	if body is GPlayer:
		ShopSprite.texture = ResourceLoader.load("uid://et110fipe65b")
