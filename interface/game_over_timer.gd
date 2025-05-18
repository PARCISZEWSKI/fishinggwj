extends Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# print(SupplyTimer.played_warning, SupplyTimer.time_left, SupplyTimer.is_stopped())
	if not SupplyTimer.played_warning and SupplyTimer.time_left <= 8.0 and not SupplyTimer.is_stopped():
		print("success")
		SupplyTimer.played_warning = true
		Audio.play_sound(load("res://assets/audio/Warning1.wav"), "Effects") 
	if SupplyTimer.time_left:
		$Label.text = "%0*d" % [2, SupplyTimer.time_to_minutes().x] + ":" + "%0*d" % [2, SupplyTimer.time_to_minutes().y]
	else:
		$Label.text = "%0*d" % [2, SupplyTimer.time_to_minutes(SupplyTimer.supply_left).x] + ":" + "%0*d" % [2, SupplyTimer.time_to_minutes(SupplyTimer.supply_left).y]

