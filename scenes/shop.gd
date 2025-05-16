extends Node2D
func _ready():
	SupplyTimer.pause_timer()

#On button press sells bass until 0 for 5 coins and then 
#puffer until 0 for 10 coins else prints not enough fish
func _on_sell_fish_pressed() -> void:
	if Currency.bass_caught > 0:
		Currency.bass_caught -= 1
		Currency.krona += 5
	elif Currency.bass_caught <= 0 && Currency.puffer_caught > 0:
		Currency.puffer_caught -= 1
		Currency.krona += 10
	else:
		print("not enough fish")
