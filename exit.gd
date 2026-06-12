extends Area2D
signal gen

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func on_place_exit(extra_arg_0: Vector2i) -> void:
	var location:Vector2i
	# Transform coordinates into numerical coords instead of grid ones
	global_position = location
