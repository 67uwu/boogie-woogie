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
	var start_room = randi_range(0,3)
	var current_room: Vector2i = Vector2i(start_room, 0)
	room_grid[start_room][0] = 1
	var direction = randi_range(1,4) #1,2:left 3,4:right 5:down
	var finished:bool = false
	var picked_room
	while not finished:
		print(direction)
		picked_room = 2
		if(direction == 1 or direction == 2):
			if(current_room.x > 0):
				current_room.x -= 1
				direction = randi_range(1,5)
			else:
				picked_room = 3
				direction = 5
				current_room.y += 1
		elif(direction == 3 or direction ==4):
			if(current_room.x < 3):
				current_room.x += 1
				direction = randi_range(1,5)
			else:
				picked_room = 3
				direction = 5
				current_room.y +=1
		elif(direction == 5):
			if(current_room.y >= 3):
				exit_room = current_room
				finished = true
			else:
				picked_room = 3
				current_room.y +=1
				direction = randi_range(1,5)
		current_room.x = clamp(current_room.x, 0, 3)
		current_room.y = clamp(current_room.y, 0, 3)
		if(not room_grid[current_room.x][current_room.y] == 1):
			room_grid[current_room.x][current_room.y] = picked_room

	fix_grid()
	make_map()

func fix_grid():
	for x in range(0,4):
		for y in range(0,4):
			if(room_grid[x][y] == 2 and (room_grid[x][y-1] == 3  or room_grid[x][y-1] == 4)):
				room_grid[x][y] == 5
			elif(room_grid[x][y] == 3 and (room_grid[x][y-1] == 3 or room_grid[x][y-1] == 4)):
				room_grid[x][y] = 4
				

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
