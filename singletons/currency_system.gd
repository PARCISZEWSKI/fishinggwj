extends CanvasLayer
class_name Currency

static var fish_caught = 0
static var bass_caught = 0

func _process(delta: float) -> void:
	$bass_number.text = var_to_str(fish_caught)

func history() -> void:
	pass

func _on_history_button_pressed() -> void:
	$history.visible = true
	get_tree().paused = true
	
func _on_exit_history_pressed() -> void:
	$history.visible = false
	get_tree().paused = false
