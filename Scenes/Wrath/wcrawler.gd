extends CharacterBody2D

@onready var BackwardsTimer = $BackwardsTimer
@onready var Sprite = $Sprite2D
@onready var ForwardsTimer = $ForwardsTimer

func _ready() -> void:
	Sprite.flip_h = true
	BackwardsTimer.start()
	
func _on_backwards_timer_timeout() -> void:
	var backwardsTween = create_tween().tween_property(self, "position:x", self.position.x + -70, 2)
	Sprite.flip_h = false
	
	await backwardsTween.finished
	
	ForwardsTimer.start()

func _on_backwards_timer_2_timeout() -> void:
	var forwardsTween = create_tween().tween_property(self, "position:x", self.position.x + 70, 2)
	Sprite.flip_h = true
	
	await forwardsTween.finished
	
	BackwardsTimer.start()
