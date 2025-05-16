extends Area2D

@export var soundDeath: AudioStream
@export var move_speed: float = 50.0
@export var move_area: Rect2 = Rect2(0, 0, 400, 300)  # Customize this
var direction: Vector2 = Vector2.RIGHT

func _ready():
	# Randomize initial direction
	direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
	# Randomize initial position within bounds
	position = Vector2(
		randf_range(move_area.position.x, move_area.end.x),
		randf_range(move_area.position.y, move_area.end.y)
	)

func _process(delta):
	position += direction * move_speed * delta
	
	# Boundary checking with bounce
	if position.x < move_area.position.x or position.x > move_area.end.x:
		direction.x *= -1
		position.x = clamp(position.x, move_area.position.x, move_area.end.x)
	
	if position.y < move_area.position.y or position.y > move_area.end.y:
		direction.y *= -1
		position.y = clamp(position.y, move_area.position.y, move_area.end.y)
	
	# Random direction changes for more natural movement
	if randf() < 0.005:  # 0.5% chance each frame
		direction = direction.rotated(randf_range(-PI/4, PI/4)).normalized()

func _on_body_entered(body) -> void:
	Currency.bass_caught += 1
	var audio_player = Audio.play_sound_2d(soundDeath, "Effects")
	audio_player.position = global_position
	queue_free()


#gamalt
#if direction.x != 0:
#$visual/bass.flip_h = direction.x < 0
#$visual/bass/outline.flip_h = direction.x < 0
