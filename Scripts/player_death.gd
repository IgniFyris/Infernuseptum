extends CanvasLayer

@onready var Logos = $Logos
@onready var DelayTimer = $Delay
@onready var SinBG = $ColorRect
@onready var ResButton = $RestartButton

@onready var SlothTitle = $SinTitles/Sloth
@onready var SlothDeath = "uid://dagyj4t8j84c4"

var PrevScene : String

func _ready() -> void:
	PrevScene = SceneLoader.get_previous_scene_path()
	
	DelayTimer.start()
	
func _on_delay_timeout() -> void:
	if PrevScene == SlothDeath:
		Logos.region_rect = Rect2(0, 0, 326.0297, 313.4017)
		
		var LTween = create_tween().tween_property(Logos, "modulate:a", 1.0, 0.5)
		
		await LTween.finished
		
		var STTween = create_tween().tween_property(SlothTitle, "modulate:a", 1.0, 1.5)
		create_tween().tween_property(SinBG, "color", Color("1f1f1fff"), 4.0)
		
		await STTween.finished
		
		create_tween().tween_property(ResButton, "modulate:a", 1.0, 1.0)
		ResButton.disabled = false

func _on_texture_button_pressed() -> void:
	SceneLoader.load_scene(PrevScene)
