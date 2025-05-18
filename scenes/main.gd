extends Node2D

func _process(delta):
	if $collectibles.mouse_on_button:
		$player.process_mode = PROCESS_MODE_DISABLED
	else:
		$player.process_mode = PROCESS_MODE_INHERIT
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	SupplyTimer.start_timer()
	
