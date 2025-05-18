extends Node

@export var start_krona: int = 50 ##Gold to start off with

@export_group("Scene Control")
@export var skipMenu: bool = false ##Turn to true to skip main menu, used for testing purposes
var startLevel: PackedScene = load("res://scenes/shop.tscn") ##Level to load when pressing the start button

@export_group("Audio")
@export var clickSound: AudioStream ##Audio stream when player click audio

#References to all notable children
@onready var start : = $menu/start
@onready var settings: = $menu/settings
@onready var back: = $settings/back
@onready var masterSlide: = $settings/master
@onready var sfxSlide: = $settings/sfx
@onready var musicSlide = $settings/music
@onready var menu: = $menu
@onready var settingsMenu: = $settings
@onready var windowToggle: = $TextureButton
#References to audio bus indexes requiered for volume control
@onready var masterBus: = AudioServer.get_bus_index("Master")
@onready var sfxBus: = AudioServer.get_bus_index("Effects")
@onready var musicBus: = AudioServer.get_bus_index("Music")


func _ready() -> void:
	SupplyTimer.pause_timer()
	get_tree().paused = false
	if skipMenu: #Skips menu if variable set to true, shortcut for testing
		initialize_game()
		get_tree().change_scene_to_packed(startLevel)
	if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN:
		windowToggle.button_pressed = true

# func _process(_delta: float) -> void: #FIXME: Ensure that the fullscreen button displays the right icon depeding on window mode
# 	if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN:
# 		windowToggle.button_pressed = true
# 	if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_WINDOWED:
# 		windowToggle.button_pressed = false

func _on_start_button_down() -> void: ##Starts level on start button press
	initialize_game()
	get_tree().change_scene_to_packed(startLevel)
	Audio.play_sound(clickSound, "Effects")

func initialize_game() -> void:
	Currency.krona = start_krona
	Currency.bass_caught = 0
	Currency.puffer_caught = 0
	SupplyTimer.supply_left = 0



func _on_settings_button_down() -> void: ##Opens settings screen
	menu.visible = false
	settingsMenu.visible = true
	Audio.play_sound(clickSound, "Effects")

#Volume control used by the sliders on settings screen
func _on_master_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_linear(masterBus, value)

func _on_music_value_changed(value:float) -> void:
	AudioServer.set_bus_volume_linear(musicBus, value)

func _on_sfx_value_changed(value:float) -> void:
	AudioServer.set_bus_volume_linear(sfxBus, value)

#Returns to main menu
func _on_back_button_down() -> void:
	menu.visible = true
	settingsMenu.visible = false
	Audio.play_sound(clickSound, "Effects")


func _on_texture_button_toggled(toggled_on:bool) -> void: #Controls if we are in fullscreen or not
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)