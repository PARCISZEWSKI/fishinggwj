extends Timer


var game_over_scene: PackedScene
@export var supply_left: float ##Seconds of supply left

func start_timer():
	start(supply_left)

func pause_timer():
	supply_left = time_left
	stop()

func time_to_minutes() -> Vector2i: ## Returns minutes(x) and seconds(y)
	var minutes: int = floor(time_left / 60)
	var seconds: int = floori(time_left) % 60
	return Vector2(minutes, seconds)


func _on_timeout() -> void:
	pass # Replace with function body.
