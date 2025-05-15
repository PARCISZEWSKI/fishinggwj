extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SupplyTimer.start_timer()

func _exit_tree() -> void:
	SupplyTimer.pause_timer()
