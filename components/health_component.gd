class_name HealthComponent
extends Node2D

@export var health: int
signal healthZero

func reduce_health(amount:int) -> void:
	health -= amount
	if health <= 0:
		healthZero.emit()
