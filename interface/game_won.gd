extends CanvasLayer

var main_menu: PackedScene = preload("res://interface/main_menu.tscn")
@export var clickSound: AudioStream
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_tree().paused = false


func _on_start_button_down() -> void:
	Audio.play_sound(clickSound, "Effects")
	get_tree().change_scene_to_packed(main_menu)
