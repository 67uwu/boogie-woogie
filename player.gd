extends CharacterBody2D

signal swap
@onready var target: Node2D = $"../swap_point"

# Physics Constants
const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const TOP_SPEED = 700
const ACCEL = 18
const JUMP_GRAVITY = 800
const FALL_GRAVITY = 1800
const COYOTE_BUFFER = 150

var can_swap: bool
var swap_timer: float
var coyote_activated: bool = true


func _physics_process(delta: float) -> void:
	if(can_swap and Input.is_action_just_pressed("swap")):
		can_swap = false
		swap_timer = 1
		var temp = target.global_position
		swap.emit()
		global_position = temp
	# Add the gravity.
	if not is_on_floor():
		if velocity.y >= 0:
			velocity.y += FALL_GRAVITY * delta
		elif velocity.y <= 0:
			if(Input.is_action_pressed("jump")):
				velocity.y += JUMP_GRAVITY * delta
			else:
				velocity.y += FALL_GRAVITY * delta
	else:
		coyote_activated = false
		

	# Handle jump.
	if Input.is_action_just_pressed("jump") and abs(velocity.y) < COYOTE_BUFFER and not coyote_activated:
		velocity.y = JUMP_VELOCITY
		coyote_activated = true

	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("left", "right")
	
	if direction:
		velocity.x = move_toward(velocity.x, direction*SPEED, ACCEL)
	else:
		velocity.x = move_toward(velocity.x, 0, ACCEL)
	
	if(velocity.x > TOP_SPEED):
		velocity.x = TOP_SPEED
	elif(velocity.x < -TOP_SPEED):
		velocity.x = -TOP_SPEED 
	swap_timer -= delta
	if(swap_timer <= 0):
		can_swap = true
	move_and_slide()
