extends TextureButton

@onready var EndlessModeButton = get_parent().get_node("EndlessModeButton")
@onready var TitleText = get_parent().get_node("Title")
@onready var ComingSoon = get_parent().get_node("ComingSoon")

@export var animation_player : AnimationPlayer
@export var initial_scene: StringName = &""

var frequency = 2.0
var amplitude = 10.0
var time = 0.0

func _process(delta):
	time += delta

	rotation_degrees = sin(time * frequency) * -1.3
	position.x += cos(time * frequency * 2) * 10 * delta 


func _on_story_mode_button_pressed():
	self.disabled = true
	EndlessModeButton.disabled = true
	var EMB_tween = create_tween().tween_property(EndlessModeButton, "modulate:a", 0.0, 1.0)
	var SMB_tween = create_tween().tween_property(self, "modulate:a", 0.0, 1.0)
	var ComingSoonTween = create_tween().tween_property(ComingSoon, "modulate:a", 0.0, 1.0)
	
	@warning_ignore("standalone_expression")
	await EMB_tween.finished && SMB_tween.finished
	
	title_fall()
	
func title_fall():
	animation_player.play("Fall_Anim")
	create_tween().tween_property(TitleText, "modulate:a", 0.0, 1.0)
	
	SceneLoader.load_scene(initial_scene)
