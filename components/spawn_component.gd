extends Node

@export var left_edge = 0
@export var right_edge = 0
@export var fishes : Array[PackedScene]

var spawn_rate = float(1)

func spawn_fish():
	var new_fish = fishes.pick_random().instantiate()
	add_child(new_fish)
	init_fish(new_fish)

func _process(delta) -> void:
	if spawn_rate <= 0:
		spawn_fish()
		spawn_rate = 1
	else:
		spawn_rate -= delta

func init_fish(fish : Fish):
	var random_side = randi_range(0,2)
	var start_position : Vector2
	#randomize x
	if random_side == 0:
		start_position.x = left_edge #Left side
		#fish.direction = Vector2(1,0) #Look right
	else:
		start_position.x = right_edge #Right side
		#fish.direction = Vector2(-1,0) #Look left
	
	#randomize y
	var random_y = randf_range(62, 200) #will change
	start_position.y = random_y
	fish.position = start_position

	fish.move_speed = 2
	print("cool")
