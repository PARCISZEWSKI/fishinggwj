extends CanvasLayer

func _process(delta: float) -> void:
	$bass_number.text = var_to_str(Currency.bass_caught)
	$krona_value.text = var_to_str(Currency.krona)
	history()
	

func history() -> void:
	$history/bass_history/bass_counter.text = var_to_str(Currency.bass_caught)

#Changes to the shop scene if in main scene and vise versa
func _on_history_button_pressed() -> void:
	if get_tree().current_scene.scene_file_path == "res://scenes/main.tscn":
		get_tree().change_scene_to_file("res://scenes/shop.tscn")
	else:
		get_tree().change_scene_to_file("res://scenes/main.tscn")
	
func _on_exit_history_pressed() -> void:
	$history.visible = false
	get_tree().paused = false
