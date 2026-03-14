extends CharacterBody2D
class_name GPlayer

@onready var CoyoteTimer = $CoyoteTimer
@onready var JumpBufferTimer = $JumpBufferTimer
@onready var CamTimer = $CamTimer
@onready var Camera = $Camera2D

@onready var Bag = $Camera2D/CanvasLayer/TextureRect

@onready var jump_velocity : float = ((2.0 * jump_height) / jump_time_to_peak) * -1.0
@onready var jump_gravity : float = ((-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)) * -1.0
@onready var fall_gravity : float = ((-2.0 * jump_height) / (jump_time_to_descent * jump_time_to_descent)) * -1.0

@export var speed = 7.0
@export var jump_height : float = 40.0
@export var jump_time_to_peak : float = 0.25
@export var jump_time_to_descent : float = 0.19

@export var BagAnim : AnimationPlayer

@export var death_scene: StringName = &""

var speed_multipilier = 30
var direction = 0
var dead = false

var coins = 0
var is_in_receiver = false
var cam = false

func _ready() -> void:
	Camera.enabled = false
	CamTimer.start()

func _physics_process(delta):
	if not dead:
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
			
		#GREED-RELATED STATEMENTS
		if is_in_receiver == true:
			if Input.is_action_pressed("give_receivers") and coins == 3:
				coins = 0
			if Input.is_action_pressed("give_receivers") and not coins == 3:
				BagAnim.play("shake")
		
		if coins == 0:
			Bag.texture = ResourceLoader.load("uid://ba2jj7pridf33")
		elif coins > 0 and coins < 3:
			Bag.texture = ResourceLoader.load("uid://bmqrepki0g6fo")
		else:
			Bag.texture = ResourceLoader.load("uid://hpyk3e0t235m")
	
func gravityget() -> float:
	return jump_gravity if velocity.y < 0.0 else fall_gravity
	
func _on_cam_timer_timeout() -> void:
	Bag.visible = true
	Camera.enabled = true
