extends Node2D

signal gen
signal place_player
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_main_gen_map() -> void:
	gen.emit()# Replace with function body.


func on_place_player() -> void:
	place_player.emit() # Replace with function body.
