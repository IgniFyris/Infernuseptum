extends CharacterBody2D
class_name Player

signal SlothDeath

@onready var CoyoteTimer = $CoyoteTimer
@onready var JumpBufferTimer = $JumpBufferTimer
@onready var CamTimer = $CamTimer

#🦥 SLOTH RING 🦥
@onready var SlothDeathTimer = $SlothDeathTimer
@onready var SlothBorder = $Camera2D/CanvasLayer/TextureRect

@onready var Camera = $Camera2D

@onready var jump_velocity : float = ((2.0 * jump_height) / jump_time_to_peak) * -1.0
@onready var jump_gravity : float = ((-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)) * -1.0
@onready var fall_gravity : float = ((-2.0 * jump_height) / (jump_time_to_descent * jump_time_to_descent)) * -1.0

@export var speed = 7.0
@export var SlothBorderAnimPlayer : AnimationPlayer
@export var jump_height : float = 40.0
@export var jump_time_to_peak : float = 0.25
@export var jump_time_to_descent : float = 0.19

@export var death_scene: StringName = &""

var speed_multipilier = 30
var direction = 0

#🦥 SLOTH RING 🦥
var is_in_slime = false

func _ready() -> void:
	Camera.enabled = false
	CamTimer.start()

func _physics_process(delta):
	
	velocity.y += gravityget() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump"):
		JumpBufferTimer.start()
		
	if	(is_on_floor() or not CoyoteTimer.is_stopped()) and not JumpBufferTimer.is_stopped() and not is_in_slime:
		velocity.y = jump_velocity

	# Get the input direction and handle the movement/deceleration.
	direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * speed * speed_multipilier
	else:
		velocity.x = move_toward(velocity.x, 0, speed * speed_multipilier)
		
	#SLOTH RING
	if ((velocity.x != 0.0) or not is_on_floor()) and not SlothDeathTimer.is_stopped():
		SlothDeathTimer.stop()
		SlothBorderAnimPlayer.stop()
	elif ((velocity.x == 0.0) or is_on_floor()) and SlothDeathTimer.is_stopped():
		SlothDeathTimer.start()
		SlothBorderAnimPlayer.play("fade")
		
	var was_on_floor = is_on_floor()

	move_and_slide()
	
	if was_on_floor and not is_on_floor():
		CoyoteTimer.start()
	
func gravityget() -> float:
	return jump_gravity if velocity.y < 0.0 else fall_gravity

#🦥 SLOTH RING 🦥
func _on_sloth_death_timer_timeout() -> void:
	SlothDeath.emit()
	SceneLoader.load_scene(death_scene)
	
func _on_cam_timer_timeout() -> void:
	Camera.enabled = true
