class_name HealthComponent
extends Node2D

@export var health: int
signal healthZero #Signal output when health reaches zero


func reduce_health(amount:int) -> void:
	health -= amount
	if health <= 0:
		healthZero.emit()
