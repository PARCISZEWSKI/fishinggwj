extends Area2D

@export var soundDeath: AudioStream
@export var move_speed: float = 50.0
@export var move_area: Rect2 = Rect2(0, 0, 400, 300)  # Customize this
@export var turn_rate: float = 0.005 # 0.5% chance each frame

var direction: Vector2 = Vector2.RIGHT
@onready var sprite = $visual/fish_3

func _ready():
	# Randomize initial direction
	direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
	# Randomize initial position within bounds
	position = Vector2(
		randf_range(move_area.position.x, move_area.end.x),
		randf_range(move_area.position.y, move_area.end.y)
	)
	_update_sprite_flip()

func _process(delta):
	position += direction * move_speed * delta
	
	# Boundary checking with bounce
	if position.x < move_area.position.x or position.x > move_area.end.x:
		direction.x *= -1
		position.x = clamp(position.x, move_area.position.x, move_area.end.x)
		_update_sprite_flip()
	
	if position.y < move_area.position.y or position.y > move_area.end.y:
		direction.y *= -1
		position.y = clamp(position.y, move_area.position.y, move_area.end.y)
	
	# Random direction changes for more natural movement
	if randf() < turn_rate:  
		direction = direction.rotated(randf_range(-PI/4, PI/4)).normalized()
		_update_sprite_flip()

func _update_sprite_flip() -> void:
	if direction.x > 0: # Moving right
		sprite.flip_h = true
	elif direction.x < 0: # Moving left
		sprite.flip_h = false

func _on_body_entered(body) -> void:
	Currency.fish3_caught += 1
	var audio_player = Audio.play_sound_2d(soundDeath, "Effects")
	audio_player.position = global_position
	queue_free()
