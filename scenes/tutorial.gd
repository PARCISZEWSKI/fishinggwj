extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Globals.first_time:
		visible = true
		get_tree().paused = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("primary"):
		visible = false
		get_tree().paused = false
