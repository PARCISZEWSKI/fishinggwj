extends CanvasLayer
@onready var windowToggle: TextureButton = $TextureButton

@export var mainMenu: PackedScene
#References to audio bus indexes requiered for volume control
@onready var masterBus: = AudioServer.get_bus_index("Master")
@onready var sfxBus: = AudioServer.get_bus_index("Effects")
@onready var musicBus: = AudioServer.get_bus_index("Music")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN:
		windowToggle.button_pressed = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("escape"):
		toggleMenu()

func toggleMenu() -> void:
	visible= not visible ## Flips visible status
	get_tree().paused = not get_tree().paused #flips


func _on_back_2_button_down() -> void:
	get_tree().change_scene_to_packed(mainMenu)


func _on_back_button_down() -> void:
	toggleMenu()


func _on_sfx_value_changed(value:float) -> void:
	AudioServer.set_bus_volume_linear(sfxBus, value)


func _on_music_value_changed(value:float) -> void:
	AudioServer.set_bus_volume_linear(musicBus, value)


func _on_master_value_changed(value:float) -> void:
	AudioServer.set_bus_volume_linear(masterBus, value)
