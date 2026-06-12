extends TileMapLayer
const START_POINT: Vector2i = Vector2i(2,2)
signal place_exit
signal place_player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_map_gen() -> void:
	set_cell(Vector2i(5,14),0, Vector2i(1,0),0)
	#do map generation here
	var exit_location = randi_range(0,1)
	if(exit_location == 0):
		exit_location = Vector2i(41, 15)
	else:
		exit_location = Vector2i(4, 15)
	place_exit.emit(exit_location)
	place_player.emit()# Replace with function body.
