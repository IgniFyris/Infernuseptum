extends CharacterBody2D
class_name WPlayer

@onready var CoyoteTimer = $CoyoteTimer
@onready var JumpBufferTimer = $JumpBufferTimer
@onready var CamTimer = $CamTimer
@onready var CalmTimer = $CalmTimer
@onready var Camera = $Camera2D

@onready var WBar1 = $Camera2D/CanvasLayer/WBar1
@onready var WBar2 = $Camera2D/CanvasLayer/WBar2
@onready var WBar3 = $Camera2D/CanvasLayer/WBar3
@onready var WBar4 = $Camera2D/CanvasLayer/WBar4

@onready var jump_velocity : float = ((2.0 * jump_height) / jump_time_to_peak) * -1.0
@onready var jump_gravity : float = ((-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)) * -1.0
@onready var fall_gravity : float = ((-2.0 * jump_height) / (jump_time_to_descent * jump_time_to_descent)) * -1.0

@export var speed = 7.0
@export var jump_height : float = 40.0
@export var jump_time_to_peak : float = 0.25
@export var jump_time_to_descent : float = 0.19
@export var WPlayerAnim : AnimationPlayer
@export var death_scene: StringName = &""

var speed_multipilier = 30
var direction = 0
var dead = false

var wrath_meter = 0

func _ready() -> void:
	Camera.enabled = false
	CamTimer.start()

func _physics_process(delta):
	if not dead:
		print(wrath_meter)
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
			
		if (Input.is_action_pressed("calm") and wrath_meter != 0) and CalmTimer.is_stopped():
			CalmTimer.start()
			wrath_meter -= 1
			print("hi")
			
		#WRATH STUFF
		if wrath_meter == 0:
			WBar1.visible = true
			WBar2.visible = false
			WBar3.visible = false
			WBar4.visible = false
		elif wrath_meter > 0 and wrath_meter < 35:
			WBar1.visible = false
			WBar2.visible = true
			WBar3.visible = false
			WBar4.visible = false
		elif wrath_meter > 34 and wrath_meter < 75:
			WBar1.visible = false
			WBar2.visible = false
			WBar3.visible = true
			WBar4.visible = false
		elif wrath_meter > 74 and wrath_meter < 100:
			WBar1.visible = false
			WBar2.visible = false
			WBar3.visible = false
			WBar4.visible = true
		elif wrath_meter == 100:
			WPlayerAnim.play("death")
			SceneLoader.load_scene(death_scene)
			
		
	
func gravityget() -> float:
	return jump_gravity if velocity.y < 0.0 else fall_gravity
	
func _on_cam_timer_timeout() -> void:
	Camera.enabled = true
