extends CharacterBody2D
enum States{INACTIVE,CHASING}
var current_state:States = States.INACTIVE
var aggro_range:float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func spawn():
	pass

func die():
	pass
