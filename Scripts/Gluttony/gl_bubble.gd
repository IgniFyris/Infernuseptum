extends Node2D

@export var BubbleAnim : AnimationPlayer
@onready var BubbleSprite = $AnimatableBody2D/Sprite2D
@onready var BubbleCol = $AnimatableBody2D/CollisionShape2D
@onready var BubbleArea = $Area2D
@onready var UntilPopTimer = $UntilPopTimer
@onready var UntilReformTimer = $UntilReformTimer

@onready var pop = $AudioStreamPlayer2D

func _ready() -> void:
	BubbleSprite.visible = true
	BubbleCol.disabled = false
	BubbleArea.monitoring = true
	BubbleAnim.stop()
	
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is GLPlayer:
		UntilPopTimer.start()
		
func _on_until_pop_timer_timeout() -> void:
	BubbleAnim.play("pop")
	
	pop.play()
	
	await BubbleAnim.animation_finished
	
	BubbleSprite.visible = false
	BubbleCol.disabled = true
	BubbleArea.monitoring = false
	
	UntilReformTimer.start()

func _on_until_reform_timer_timeout() -> void:
	BubbleAnim.play_backwards("pop")
	
	await BubbleAnim.animation_finished
	
	BubbleSprite.visible = true
	BubbleCol.disabled = false
	BubbleArea.monitoring = true

func _on_area_2d_body_exited(_body: Node2D) -> void:
	pass
