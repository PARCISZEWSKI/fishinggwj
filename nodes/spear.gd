extends RigidBody2D

@export var throw_force: float = 5

enum SPEARSTATUS {
	ready, 
	thrown,
	returning
}

@onready var timer: Timer = $castCharge


var direction: Vector2
var current_state: SPEARSTATUS = SPEARSTATUS.ready
func _ready() -> void:
	freeze = true


func _process(delta: float) -> void:
	match current_state:
		SPEARSTATUS.ready:

			var mouse_pos = get_global_mouse_position()
			direction = (mouse_pos - global_position).normalized()
			rotation = direction.angle() - PI/2

			if Input.is_action_just_pressed("primary"):
				useItem()
		SPEARSTATUS.thrown:
			if Input.is_action_just_pressed("primary"):
				resetItem()

func useItem():
	freeze = false
	apply_impulse(direction * throw_force)

func resetItem():
	pass

func _on_health_component_health_zero() -> void:
	queue_free()


func _on_timer_timeout() -> void:
	pass # Replace with function body.
