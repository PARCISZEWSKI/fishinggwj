extends Timer

var game_over_scene: PackedScene = load("res://interface/game_over.tscn")
static var supply_left: float = 0  # Default time (seconds)
var played_warning: = false


func _ready():	
	# Connect timeout signal (if needed)
	timeout.connect(_on_timeout)
	one_shot = true


func start_timer():
	if supply_left <= 0:
		print("Cannot start timer: time is zero!")
		return
	
	print("start:", supply_left)
	wait_time = supply_left
	start()  # Uses the built-in Timer (since this script extends Timer	)

func pause_timer():
	if is_stopped():
		return  # Already paused
	
	print("pause:", time_left, supply_left)
	supply_left = time_left
	stop()

func add_time(seconds: float):
	supply_left = max(supply_left + seconds, 0)  # Prevent negative time
	print("Added time. New supply: ", supply_left)
	
	# Restart timer if it was running
	if not is_stopped():
		start_timer()

func time_to_minutes(time: float = time_left if not is_stopped() else supply_left) -> Vector2i:
	var time_remaining = time if time > 0 else 0
	var minutes: int = floor(time_remaining / 60)
	var seconds: int = floori(time_remaining) % 60
	return Vector2i(minutes, seconds)

func _on_timeout():
	supply_left = 0  # Ensure it doesn't go negative
	print("Supply depleted!")
	Audio.play_sound(load("res://assets/audio/Death1.wav"), "Effects")
	if game_over_scene:
		get_tree().change_scene_to_packed(game_over_scene)
