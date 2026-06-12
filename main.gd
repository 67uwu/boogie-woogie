extends Node2D
signal gen_map

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	gen_map.emit() # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
