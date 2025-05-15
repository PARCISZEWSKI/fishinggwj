extends Timer


var game_over_scene: PackedScene
static var supply_left: float ##Seconds of supply left

func start_timer():
	print("start:", time_left, supply_left)
	start(supply_left)

func pause_timer():
	print("pause:", time_left, supply_left)
	supply_left = time_left
	stop()

func time_to_minutes(time: float = time_left) -> Vector2i: ## Returns minutes(x) and seconds(y)
	var minutes: int = floor(time / 60)
	var seconds: int = floori(time) % 60
	return Vector2(minutes, seconds)


func _on_timeout() -> void:
	pass # Replace with function body.
