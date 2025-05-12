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
	#FIXED IT: The problem was that the 0 position as the lowerbound is a local position of the parent,
	#It means that when the fish spawn on the left boundry they won´t move as the condition is never true
	# I saw that the intention is to make the fish switch direction when reaching the boundary so I made the boundary be
	# half the viewport size in the negative on the x axis assuming that the parent node is cenetered
	# FIXME: Add export variables, BTW mátt eyða þessum commentum eftir mig
	if position.x < get_viewport_rect().size.x/-2 or position.x > get_viewport_rect().size.x: 
		direction.x *= -1  # Reverse x direction
	#There isn´t an issue here as the 0 of the y coordinate is the parent positition, but the other condition is
	#problematic as it allows fish to spawn well below would recommend also changing variables
	#FIXME: Add export variable
	if position.y < 0 or position.y > get_viewport_rect().size.y:
		direction.y *= -1  # Reverse y direction

func _on_timer_timeout():  #Change direction randomly needs timer?
	direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
	if direction.x != 0:
		$Sprite2D.flip_h = direction.x < 0
