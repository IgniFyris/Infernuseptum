extends CharacterBody2D
class_name PPlayer

signal BossStart
signal PlayerDeath

@onready var CoyoteTimer = $CoyoteTimer
@onready var JumpBufferTimer = $JumpBufferTimer
@onready var CamTimer = $CamTimer
@onready var Camera = $Camera2D
@onready var ChangeColorTimer = $ChangeColorTimer
@onready var ColorFilter = $Camera2D/OtherSins/ColorRect

@onready var HFull = $Camera2D/CanvasLayer/TextureRect
@onready var HHalf = $Camera2D/CanvasLayer/TextureRect2
@onready var HEmpty = $Camera2D/CanvasLayer/TextureRect3

@onready var jump_velocity : float = ((2.0 * jump_height) / jump_time_to_peak) * -1.0
@onready var jump_gravity : float = ((-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)) * -1.0
@onready var fall_gravity : float = ((-2.0 * jump_height) / (jump_time_to_descent * jump_time_to_descent)) * -1.0

@export var speed = 7.0
@export var jump_height : float = 40.0
@export var jump_time_to_peak : float = 0.25
@export var jump_time_to_descent : float = 0.19

@export var death_scene: StringName = &""
@export var WPlayerAnim : AnimationPlayer
@export var FlashAnim : AnimationPlayer

@onready var laugh = $AudioStreamPlayer2D

var speed_multipilier = 30
var direction = 0
var dead = false
var in_cutscene = false

var pride_meter = 0
var life = 3
var color = [Color(0.558, 0.558, 0.558, 1.0),  Color(0.899, 0.81, 0.168, 1.0), Color(1.0, 0.521, 0.724, 1.0), Color(0.776, 0.364, 0.923, 1.0), Color(0.479, 0.802, 0.254, 1.0), Color(0.843, 0.112, 0.0, 1.0),]
var num = 0
var other_dead = false

func _ready() -> void:
	HFull.visible = false
	ColorFilter.visible = false
	Camera.enabled = false
	CamTimer.start()

func _physics_process(delta):
	if not dead and not in_cutscene:
		velocity.y += gravityget() * delta

		# Handle jump.
		if Input.is_action_just_pressed("jump"):
			JumpBufferTimer.start()
			
		if	(is_on_floor() or not CoyoteTimer.is_stopped()) and not JumpBufferTimer.is_stopped():
			velocity.y = jump_velocity

		# Get the input direction and handle the movement/deceleration.
		direction = Input.get_axis("move_left", "move_right")
		if direction:
			velocity.x = direction * speed * speed_multipilier
		else:
			velocity.x = move_toward(velocity.x, 0, speed * speed_multipilier)
			
		var was_on_floor = is_on_floor()

		move_and_slide()
		
		if was_on_floor and not is_on_floor():
			CoyoteTimer.start()
			
		#PRIDEE
		if life == 3:
			HFull.visible = true
			HHalf.visible = false
			HEmpty.visible = false
		elif life == 2:
			HFull.visible = false
			HHalf.visible = true
			HEmpty.visible = false
		elif life == 1:
			HFull.visible = false
			HHalf.visible = true
			HEmpty.visible = false
		elif life == 0:
			HFull.visible = false
			HHalf.visible = false
			HEmpty.visible = true
			
			dead = true
			WPlayerAnim.play("death")
			SceneLoader.load_scene(death_scene)
			PlayerDeath.emit()
	if other_dead:
		WPlayerAnim.play("death")
		SceneLoader.load_scene(death_scene)
		PlayerDeath.emit()
		dead = true
		other_dead = false
	
func gravityget() -> float:
	return jump_gravity if velocity.y < 0.0 else fall_gravity
	
func _on_cam_timer_timeout() -> void:
	#Camera.enabled = true
	pass

func _on_change_color_timer_timeout() -> void:
	if num < 5:
		num += 1
	else:
		num = 0
		
	ColorFilter.visible = true
	var tween = create_tween().tween_property(ColorFilter, "color", color[num], 3)
	
	await tween.finished
	
	ChangeColorTimer.start()

func _on_bait_cutscene_done() -> void:
	BossStart.emit()
	FlashAnim.play("flash")
	laugh.play()
	
	await FlashAnim.animation_finished
	
	HFull.visible = true
	ChangeColorTimer.start()
	ColorFilter.visible = true

func _on_pride_boss_death() -> void:
	WPlayerAnim.stop()
	in_cutscene = true
