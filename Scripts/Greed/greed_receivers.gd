extends Area2D

@onready var GReceiverSprite = $Sprite2D

var body_in_receiver = false
var playerCoins : float

func _ready() -> void:
	GReceiverSprite.texture = ResourceLoader.load("uid://cg28j5kxva8hs")
	print(self.rotation)
	
func _process(_delta: float) -> void:
	if body_in_receiver:
		if Input.is_action_pressed("give_receivers") and playerCoins == 3:
			GReceiverSprite.texture = ResourceLoader.load("uid://cg28j5kxva8hs")
			
			leave_scene()
			self.monitorable = false

func _on_body_entered(body: Node2D) -> void:
	if body is GPlayer:
		playerCoins = body.coins
		body_in_receiver = true
		body.is_in_receiver = true
		GReceiverSprite.texture = ResourceLoader.load("uid://dxcvh3ynu560d") 

func _on_body_exited(body: Node2D) -> void:
	if body is GPlayer:
		body_in_receiver = false
		body.is_in_receiver = false
		GReceiverSprite.texture = ResourceLoader.load("uid://cg28j5kxva8hs")

func leave_scene() -> void:
	if self.rotation == 0:
		var tw = create_tween().tween_property(self, "position:x", self.position.x - 150, 1)
		
		await tw.finished
		
		queue_free()
	if self.rotation_degrees == -180.0:
		var tw = create_tween().tween_property(self, "position:x", self.position.x + 150, 1)
		
		await tw.finished
		
		queue_free()
	if self.rotation_degrees == 90.0:
		var tw = create_tween().tween_property(self, "position:y", self.position.y - 100, 1)
		
		await tw.finished
		
		queue_free()
