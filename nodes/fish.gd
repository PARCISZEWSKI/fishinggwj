class_name Fish
extends Area2D

var starting_position: Vector2
var direction: Vector2 = Vector2.RIGHT  # Initialize with a default direction
var move_speed = 100.0

func _ready():
	starting_position = position
	# Set a random initial direction
	direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()

func _process(delta: float) -> void:
	position += direction * move_speed * delta
	
	# boundary checking
	if position.x < 0 or position.x > get_viewport_rect().size.x:
		direction.x *= -1  # Reverse x direction
	if position.y < 0 or position.y > get_viewport_rect().size.y:
		direction.y *= -1  # Reverse y direction

func _on_timer_timeout():  #Change direction randomly needs timer?
	direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
	if direction.x != 0:
		$Sprite2D.flip_h = direction.x < 0
