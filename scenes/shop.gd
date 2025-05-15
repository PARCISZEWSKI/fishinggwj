extends Node2D

#On button press sells 1 fish for 5 coins
func _on_sell_fish_pressed() -> void:
	if Currency.bass_caught > 0:
		Currency.bass_caught -= 1
		Currency.krona += 5
	else:
		print("not enough fish")
