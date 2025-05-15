extends Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SupplyTimer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void: 
	if SupplyTimer.wait_time:
		$Label.text = "%0*d" % [2, SupplyTimer.time_to_minutes().x] + ":" + "%0*d" % [2, SupplyTimer.time_to_minutes().y]
	else:
		$Label.text = "%0*d" % [2, SupplyTimer.time_to_minutes(SupplyTimer.supply_left).x] + ":" + "%0*d" % [2, SupplyTimer.time_to_minutes(SupplyTimer.supply_left).y]

