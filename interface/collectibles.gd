extends CanvasLayer

var mouse_on_button: bool = false ##Is true when mouse hovers over map button

func _process(delta: float) -> void:
	if get_parent().is_in_group('shop'):
		$history_button.flip_h = true
	else:
		$history_button.flip_h = false
	$bass_number.text = var_to_str(Currency.bass_caught)
	$puffer_number.text = var_to_str(Currency.puffer_caught)
	$krona_value.text = var_to_str(Currency.krona) + " kr"
	$fish3_number.text = var_to_str(Currency.fish3_caught)
	history()
	

func history() -> void:
	$history/bass_history/bass_counter.text = var_to_str(Currency.bass_caught)

#Changes to the shop scene if in main scene and vise versa
func _on_history_button_pressed() -> void:

	if get_tree().current_scene.scene_file_path == "res://scenes/shop.tscn":
		if SupplyTimer.supply_left:
			get_tree().change_scene_to_file("res://scenes/main.tscn")
	else:
		get_tree().change_scene_to_file("res://scenes/shop.tscn")
		
	
func _on_exit_history_pressed() -> void:
	$history.visible = false
	get_tree().paused = false

#Shitter fix svo ad characterinn er ekki ad skjota tegar madur ytur a takkan
func _on_history_button_mouse_exited() -> void:
	mouse_on_button = false

func _on_history_button_mouse_entered() -> void:
	mouse_on_button = true
