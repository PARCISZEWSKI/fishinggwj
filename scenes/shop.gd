extends Node2D

@export var bass_price: int = 5
@export var puffer_price: int = 10
@export var fish3_price: int = 20
@export var supply_price: int = 50
@export var supply_amount: float = 10.0
@export var debt_cost: float = 500

@export var buySound: AudioStream
@export var noBuy: AudioStream
@export var winSound: AudioStream

var game_won: PackedScene = load("res://interface/game_won.tscn")

func _ready():
	SupplyTimer.pause_timer()

#On button press sells bass until 0 for 5 coins and then 
#puffer until 0 for 10 coins and so on
func _on_sell_fish_pressed() -> void:
	if Currency.bass_caught > 0:
		Audio.play_sound(buySound, "Effects")
		Currency.bass_caught -= 1
		Currency.krona += bass_price
	elif Currency.bass_caught <= 0 && Currency.puffer_caught > 0:
		Audio.play_sound(buySound, "Effects")
		Currency.puffer_caught -= 1
		Currency.krona += puffer_price
	elif Currency.bass_caught <= 0 && Currency.puffer_caught <= 0 && Currency.fish3_caught > 0:
		Audio.play_sound(buySound, "Effects")
		Currency.fish3_caught -= 1
		Currency.krona += fish3_price
	else:
		Audio.play_sound(noBuy, "Effects")
		print("not enough fish")


func _on_buy_time_button_down() -> void:
	if Currency.krona >= supply_price:
		Audio.play_sound(buySound, "Effects")
		Currency.krona -= supply_price
		SupplyTimer.add_time(supply_amount)
	else: 
		Audio.play_sound(noBuy, "Effects")
		print("Skibidi")


func _on_pay_debt_button_down() -> void:
	if Currency.krona >= debt_cost:
		Audio.play_sound(winSound, "Effects")
		if game_won:
			get_tree().change_scene_to_packed(game_won)
	else:
		Audio.play_sound(noBuy, "Effects")
