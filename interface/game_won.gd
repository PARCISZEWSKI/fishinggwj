extends CanvasLayer

var main_menu: PackedScene = preload("res://interface/main_menu.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_tree().paused = false


func _on_start_button_down() -> void:
	get_tree().change_scene_to_packed(main_menu)
