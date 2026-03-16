extends Area2D

signal CutsceneDone

@export var BaitAnim : AnimationPlayer

@onready var transforming = $AudioStreamPlayer2D

func _on_body_entered(body: Node2D) -> void:
	if body is PPlayer:
		body.in_cutscene = true
		BaitAnim.play("transform")
		transforming.play()
		
		await BaitAnim.animation_finished
		
		CutsceneDone.emit()
		body.in_cutscene = false
		queue_free()
