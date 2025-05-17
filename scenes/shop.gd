extends Node2D

@export var bass_price: int = 5
@export var puffer_price: int = 10
@export var fish3_price: int = 20
@export var supply_price: int = 50
@export var supply_amount: float = 10.0


func _ready():
	SupplyTimer.pause_timer()

#On button press sells bass until 0 for 5 coins and then 
#puffer until 0 for 10 coins else prints not enough fish
func _on_sell_fish_pressed() -> void:
	if Currency.bass_caught > 0:
		Currency.bass_caught -= 1
		Currency.krona += bass_price
	elif Currency.bass_caught <= 0 && Currency.puffer_caught > 0:
		Currency.puffer_caught -= 1
		Currency.krona += puffer_price
	elif Currency.bass_caught <= 0 && Currency.puffer_caught <= 0 && Currency.fish3_caught > 0:
		Currency.fish3_caught -= 1
		Currency.krona += fish3_price
	else:
		print("not enough fish")


func _on_buy_time_button_down() -> void:
	if Currency.krona >= supply_price:
		Currency.krona -= supply_price
		SupplyTimer.add_time(supply_amount)
	else: 
		print("Skibidi")
