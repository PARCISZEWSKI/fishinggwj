class_name Fish
extends Area2D


@export var move_speed = 100.0
@export var soundDeath: AudioStream

var starting_position: Vector2
var direction: Vector2 = Vector2.RIGHT  # Initialize with a default direction

func _ready():
	starting_position = position
	# Set a random initial direction
	direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()

func _process(delta: float) -> void:
	position += direction * move_speed * delta
	
	# boundary checking 
	# FIXME: Add export variables, BTW mátt eyða þessum commentum eftir mig
	if position.x < get_viewport_rect().size.x/-2 or position.x > get_viewport_rect().size.x: 
		direction.x *= -1  # Reverse x direction
	#FIXME: Add export variable
	if position.y < 0 or position.y > get_viewport_rect().size.y:
		direction.y *= -1  # Reverse y direction

func _exit_tree() -> void:
	pass

func _on_timer_timeout():  #Change direction randomly
	direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
	if direction.x != 0:
		$visual/bass.flip_h = direction.x < 0
		$visual/bass/outline.flip_h = direction.x < 0

func _on_body_entered(body) -> void:
	Currency.bass_caught += 1
	queue_free()
	var audio_player = Audio.play_sound_2d(soundDeath, "Effects")
	audio_player.position = global_position
