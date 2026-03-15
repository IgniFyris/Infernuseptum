extends Node2D

@export var Player : PPlayer
@export var PlayerAnim : AnimationPlayer
@export var Sprite : Sprite2D

func _process(_delta):
	if not Player.dead:
		if Player.direction == 1:
			Sprite.flip_h = false
		elif Player.direction == -1:
			Sprite.flip_h = true

		if abs(Player.velocity.x) > 0.0:
			PlayerAnim.play("walk")
		else:
			PlayerAnim.play("idle")
			
		if Player.velocity.y < 0.0:
			PlayerAnim.play("jump")
		elif Player.velocity.y > 0.0:
			PlayerAnim.play("fall")
