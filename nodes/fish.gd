class_name Fish
extends Area2D

var move_speed = 100.0

##States in statemachine
enum FISHSTATUS {
    ready,
    moving,
    caught
}

func _process(delta) -> void:
    pass