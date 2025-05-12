extends RigidBody2D

@export var torque_strength: float = 30.0 ##How fast it rotates
@export var rotation_threshold: float = 0.5 ##How close to zero it is when it stops rotating

#@export var max_speed_for_full_torque: float = 500.0

func _physics_process(delta: float) -> void:
	if abs(rotation) > rotation_threshold:
		# FIXME: Make spear rotate downards quicker the slower it goes
		#var speed = linear_velocity.length()
		#var speed_factor = clamp(speed / max_speed_for_full_torque, 0.0, 1.0)
		var torque = -rotation * torque_strength# * (1.0 - speed_factor)
		apply_torque_impulse(torque)
	
