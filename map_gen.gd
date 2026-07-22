extends TileMapLayer
const START_POINT: Vector2i = Vector2i(2,2)
signal place_exit
signal place_player

var room_grid = [[6,6,6,6],[6,6,6,6],[6,6,6,6],[6,6,6,6]] #columns outside, rows inside
#There are 6 types of rooms:
#1: start rooms (always horizontal ---- ) (guranteed to have one)
#2: horizontal normal rooms ------
#3: T shape rooms
#4: + shape rooms
#5: upside down T shape rooms
#6: extras
var exit_room: Vector2i
#where in the grid the exit is
var path: Array[Vector2i] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_map_gen() -> void:
	fill_grid()
	#do map generation here
	var exit_location = randi_range(0,1)
	if(exit_location == 0):
		exit_location = Vector2i(41, 15)
	else:
		exit_location = Vector2i(4, 15)
	place_exit.emit()
	place_player.emit()# Replace with function body.

func empty_map():
	pass

func fill_grid():
	var current_room: Vector2i = Vector2i(randi_range(0,3), 0)
	room_grid[current_room.x][current_room.y] = 1
	var new_direction:int = randi_range(1,4) #1,2,3,4:stay on same floor 5:down
	var picked_room: int
	var last_room
	while true:
		last_room = current_room
		print("dir:", new_direction)
		#print("current_room", current_room)
		if(new_direction == 5):
			if(current_room.y == 3):
				exit_room = current_room
				break
			else:
				picked_room = 5
				room_grid[current_room.x][current_room.y] = 3
				current_room.y += 1
		else:
			if(new_direction < 3):#head left
				if(current_room.x == 0):
					if(current_room.y == 3):
						exit_room = current_room
						break
					else:
						picked_room = 5
						room_grid[current_room.x][current_room.y] = 3
						current_room.y += 1
				else:
					picked_room = 2
					current_room.x -= 1
			else:
				if(current_room.x == 3):
					if(current_room.y == 3):
						exit_room = current_room
						break
					else:
						picked_room = 5
						room_grid[current_room.x][current_room.y] = 3
						current_room.y += 1
				else:
					picked_room = 2
					current_room.x += 1 
		current_room.x = clamp(current_room.x, 0, 3)
		current_room.y = clamp(current_room.y, 0, 3)
		if(room_grid[current_room.x][current_room.y] == 6):
			room_grid[current_room.x][current_room.y] = picked_room
		else:
			current_room = last_room
		new_direction = randi_range(1,5)
	fix_grid()
	make_map()

func fix_grid():
	for x in range(0,4):
		for y in range(1,4):
			if(room_grid[x][y] == 2 and (room_grid[x][y-1] == 3  or room_grid[x][y-1] == 4)):
				room_grid[x][y] == 5
			elif(room_grid[x][y] == 3 and (room_grid[x][y-1] == 3 or room_grid[x][y-1] == 4)):
				room_grid[x][y] = 4
	for x in range(0,4):
		for y in range(0,3):
			if(room_grid[x][y] == 2 and (room_grid[x][y+1] == 4 or room_grid[x][y+1] == 5)):
				room_grid[x][y] == 3
			elif(room_grid[x][y] == 5 and(room_grid[x][y+1] == 4 or room_grid[x][y+1] == 5)):
				room_grid[x][y] == 4

func make_map():
	for x in range(0,4):
		for y in range(0,4):
			make_room(x, y, room_grid[x][y])
	
func make_room(x:int, y:int, room_type:int):
	var pattern = get_pattern(get_rect_from_map(4*room_type+59, 31, 3,5))
	set_pattern(Vector2i((x*13 -8)+13, (y*7-4)+6), pattern)
	
func get_rect_from_map(x:int ,y:int, width:int, height:int):
	var tiles: Array[Vector2i] = []
	for i in range(width):
		for p in range(height):
			tiles.append(Vector2i(i+x,p+y))
	return tiles 
