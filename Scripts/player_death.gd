extends CanvasLayer

@onready var Logos = $Logos
@onready var DelayTimer = $Delay
@onready var SinBG = $ColorRect
@onready var ResButton = $RestartButton

@onready var SlothTitle = $SinTitles/Sloth
@onready var SlothDeath = "uid://dagyj4t8j84c4"

@onready var GreedTitle = $SinTitles/Greed
@onready var GreedDeath = "uid://bv7herqgc7fnv"

@onready var LustTitle = $SinTitles/Lust
@onready var LustDeath = "uid://c725gkt87eq1a"

@onready var EnvyTitle = $SinTitles/Envy
@onready var EnvyDeath = "uid://cmu8favv2d85q"

@onready var GluttonyTitle = $SinTitles/Gluttony
@onready var GluttonyDeath = "uid://d353el0o6o1go"

@onready var WrathTitle = $SinTitles/Wrath
@onready var WrathDeath = "uid://b8keb87g85h2m"

@onready var PrideTitle = $SinTitles/Pride
@onready var PrideDeath = "uid://dx1rkeaxlauvg"

var PrevScene : String

func _ready() -> void:
	PrevScene = SceneLoader.get_previous_scene_path()
	
	DelayTimer.start()
	
func _on_delay_timeout() -> void:
	if PrevScene == SlothDeath:
		death_anim(0, 0, 326.0297, 313.4017, SlothTitle, Color("1f1f1fff"))
	if PrevScene == GreedDeath:
		death_anim(79.37, 350, 326.0297, 313.4017, GreedTitle, Color("6e6c14ff"))
	if PrevScene == LustDeath:
		death_anim(312.915, 0, 326.0297, 313.4017, LustTitle, Color("61004dff"))
	if PrevScene == EnvyDeath:
		death_anim(454.73, 350, 326.0297, 313.4017, EnvyTitle, Color("4c205dff"))
	if PrevScene == GluttonyDeath:
		death_anim(626.935, 0, 326.0297, 313.4017, GluttonyTitle, Color("0f442fff"))
	if PrevScene == WrathDeath:
		death_anim(800, 350, 326.0297, 313.4017, WrathTitle, Color("59000cff"))
	if PrevScene == PrideDeath:
		death_anim(931.36, 0, 326.0297, 313.4017, PrideTitle, Color("9b5b0fff"))

func _on_texture_button_pressed() -> void:
	SceneLoader.load_scene(PrevScene)

func death_anim(x, y, w, h, title, color) -> void:
	Logos.region_rect = Rect2(x, y, w, h)
			
	var LTween = create_tween().tween_property(Logos, "modulate:a", 1.0, 0.5)
	
	await LTween.finished
	
	var STTween = create_tween().tween_property(title, "modulate:a", 1.0, 1.5)
	create_tween().tween_property(SinBG, "color", color, 4.0)
	
	await STTween.finished
	
	create_tween().tween_property(ResButton, "modulate:a", 1.0, 1.0)
	ResButton.disabled = false
