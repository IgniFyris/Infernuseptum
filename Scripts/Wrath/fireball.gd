extends Area2D

@onready var until_reform = $UntilReform
@onready var fly_through = $FlyThrough
@onready var AnimPlayer = $AnimationPlayer

var death_scene = "uid://c6gsuhs4qkhhw"
var burnt_out = false
var og_pos_x

func _ready() -> void:
	fly_through.start()
	og_pos_x = self.position.x

func _on_body_entered(body: Node2D) -> void:
	if body is WPlayer:
		body.dead = true
		body.WPlayerAnim.play("death")
		SceneLoader.load_scene(death_scene)
		
	if burnt_out == false:
		AnimPlayer.play("shoot")

func _on_fly_through_timeout() -> void:
	self.position.x = og_pos_x
	var tween = create_tween().tween_property(self, "position:x", og_pos_x + 100, 2)
	
	await tween.finished
	
	AnimPlayer.stop()
	burnt_out = true
	AnimPlayer.play("die")
	
	await AnimPlayer.animation_finished
	
	until_reform.start()

func _on_until_reform_timeout() -> void:
	burnt_out = false
	fly_through.start()
	
