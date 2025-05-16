extends Node2D

@export var fish_scene: Array[PackedScene]
@export var max_fish: int = 10
@export var spawn_area: Rect2 = Rect2(0, 0, 400, 300)  # Same as fish move area
@export var spawn_rate: float = 1.0  # Seconds between spawn attempts

var _spawn_timer: float = 0.0

func _ready():
	# Initial spawn
	for i in range(min(3, max_fish)):
		spawn_fish()

func _process(delta):
	_spawn_timer += delta
	if _spawn_timer >= spawn_rate:
		_spawn_timer = 0.0
		spawn_fish()

func spawn_fish():
	if get_tree().get_nodes_in_group("fish").size() >= max_fish:
		return
	
	var new_fish = fish_scene.pick_random().instantiate()
	new_fish.move_area = spawn_area  # Pass our area to the fish
	new_fish.position = Vector2(
		randf_range(spawn_area.position.x, spawn_area.end.x),
		randf_range(spawn_area.position.y, spawn_area.end.y)
	)
	new_fish.add_to_group("fish")
	add_child(new_fish)

# Visual of spawn area for debug
#func _draw():
#	draw_rect(spawn_area, Color(1, 0, 0, 0.2), true)
#	draw_rect(spawn_area, Color(1, 0, 0, 0.5), false, 2.0)
