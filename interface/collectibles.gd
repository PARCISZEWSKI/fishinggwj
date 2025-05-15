extends CanvasLayer

func _process(delta: float) -> void:
	$bass_number.text = var_to_str(Currency.fish_caught)
	history()
	

func history() -> void:
	$history/bass_history/bass_counter.text = var_to_str(Currency.bass_caught)

func _on_history_button_pressed() -> void:
	$history.visible = true
	get_tree().paused = true
	
func _on_exit_history_pressed() -> void:
	$history.visible = false
	get_tree().paused = false
