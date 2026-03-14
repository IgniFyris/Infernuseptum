extends Area2D

@onready var ShopSprite = $Sprite2D

var PlayerNearShop = false

signal PlayerEnteredShop

func _ready() -> void:
	ShopSprite.texture = ResourceLoader.load("uid://et110fipe65b")
	
func _process(_delta: float) -> void:
	if PlayerNearShop == true:
		if Input.is_action_pressed("enter_shop"):
			PlayerEnteredShop.emit()
			queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body is GPlayer:
		PlayerNearShop = true
		ShopSprite.texture = ResourceLoader.load("uid://couwx6d4r4mks")

func _on_body_exited(body: Node2D) -> void:
	if body is GPlayer:
		PlayerNearShop = false
		ShopSprite.texture = ResourceLoader.load("uid://et110fipe65b")
