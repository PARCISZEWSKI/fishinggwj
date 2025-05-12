extends Node2D

@export var left_edge = 0
@export var right_edge = 0
@export var fishes: Array[PackedScene]

var spawn_rate = float(1)

func _ready():
    randomize()  # Ensure different random patterns each run

func spawn_fish():
    var new_fish = fishes.pick_random().instantiate()
    add_child(new_fish)
    init_fish(new_fish)

func _process(delta) -> void:
    if spawn_rate <= 0:
        spawn_fish()
        spawn_rate = randf_range(0.5, 2.0)  # Random spawn interval
    else:
        spawn_rate -= delta

func init_fish(fish: Fish):
    # Randomize spawn side (0 = left, 1 = right)
    var random_side = randi() % 2
    var start_position = Vector2()
    
    if random_side == 0:
        start_position.x = left_edge
        fish.direction = Vector2(1, randf_range(-0.3, 0.3)).normalized()  # Right with slight angle
    else:
        start_position.x = right_edge
        fish.direction = Vector2(-1, randf_range(-0.3, 0.3)).normalized()  # Left with slight angle
    
    # Random Y position within screen bounds
    var viewport_height = get_viewport_rect().size.y
    start_position.y = randf_range(40, viewport_height - 40)  # Keep away from edges
    
    fish.position = start_position
    fish.move_speed = randf_range(80, 150)  # Random speed if your Fish class has this variable