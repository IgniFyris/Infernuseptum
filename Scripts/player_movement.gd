extends CharacterBody2D

@onready var CoyoteTimer = $CoyoteTimer

@export var speed = 10.0
@export var jump_power = 10

var speed_multipilier = 30
var jump_multiplier = -30
var direction = 0
var gravity = 700

#const SPEED = 300.0
#const JUMP_VELOCITY = -400.0


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump"):
		$JumpBufferTimer.start()
		
	if	(is_on_floor() or not CoyoteTimer.is_stopped()) and not $JumpBufferTimer.is_stopped():
		velocity.y = jump_power * jump_multiplier

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
