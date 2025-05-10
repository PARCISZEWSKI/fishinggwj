extends Node2D

@export var availableItems: Array[Enums.ITEMS]

enum PLAYERSTATE {
	idle,
	active
}
var current_state: PLAYERSTATE = PLAYERSTATE.idle
var current_item: Enums.ITEMS



func _process(delta: float) -> void:

	match current_state:
		PLAYERSTATE.idle:

			if Input.is_action_pressed('primary'):
				useItem()
		
		PLAYERSTATE.active:
			pass

func useItem() -> void:
	var target: Vector2 = get_global_mouse_position()
	current_state = PLAYERSTATE.active


func addItem() -> void:
	pass
