extends RigidBody2D

enum SPEARSTATUS {
	ready, 
	thrown
}

@onready var timer: Timer = $Timer

func _ready() -> void:
	freeze = true


func _process(delta: float) -> void:
	var mouse_pos = get_global_mouse_position()
	var direction = (mouse_pos - global_position).normalized()
		
	# Calculate the angle and set rotation
	rotation = direction.angle() - PI/2


func useItem():
	pass


func _on_health_component_health_zero() -> void:
	queue_free()


func _on_timer_timeout() -> void:
	pass # Replace with function body.
