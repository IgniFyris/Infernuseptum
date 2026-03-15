extends CharacterBody2D

@onready var BackwardsTimer = $BackwardsTimer
@onready var Sprite = $Sprite2D
@onready var ForwardsTimer = $ForwardsTimer

func _ready() -> void:
	BackwardsTimer.start()
	
func _on_backwards_timer_timeout() -> void:
	var backwardsTween = create_tween().tween_property(self, "position:y", self.position.y + -70, 2)
	
	await backwardsTween.finished
	
	ForwardsTimer.start()

func _on_forwards_timer_timeout() -> void:
	var forwardsTween = create_tween().tween_property(self, "position:y", self.position.y + 70, 2)
	
	await forwardsTween.finished
	
	BackwardsTimer.start()
