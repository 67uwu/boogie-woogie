extends "res://enemy.gd"

const SPEED = 100
const GRAVITY = 50
const JUMP_VEL = -400

var target_position


func _ready() -> void:
	aggro_range = 250


func _physics_process(delta: float) -> void:
	if(not is_on_floor()):
		velocity.y += GRAVITY
	elif(is_on_wall()):
		velocity.y = JUMP_VEL
	target_position = $"../player".global_position
	var dist:float = global_position.distance_to(target_position)
	if(current_state == States.INACTIVE):
		velocity.x = 0
		if(dist < aggro_range):
			current_state = States.CHASING
	if(current_state == States.CHASING):
		velocity.x = ((target_position-global_position).normalized()).x*SPEED
	
	move_and_slide()
	
