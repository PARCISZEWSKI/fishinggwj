extends Node2D

@export_group("Customizable variable")
@export var throw_force: float = 105 ##Force spear is throw with
@export var spearPhysics: PackedScene ##Scene to be loaded
@export var oscillation_speed: float = PI/2.0 ##Bigger number -> faster
@export var soundReady: AudioStream
@export var soundThrow: AudioStream

@export_group("Wobble")
@export var wobble_amount: float = 0.2 ##Higher = more wobble
@export var wobble_speed_multiplier: float = 3.0 ##Higher = faster wobble

var direction: Vector2 ##Direction to mouseposition
var current_state: SPEARSTATUS = SPEARSTATUS.ready ##Current state in statemachine
var spearChild: RigidBody2D ##Reference to spawned physics spear
var oscillation_time: float = 0.0 ##Tracks project time #FIXME: need to be reset once in a while, isn't currently
var oscillation: float ##Output oscillation between [0, 1]
var charging_start_rotation: float ##Stores initial rotation before charging

#References to children
@onready var sprite: Node2D = $visual
@onready var chargeBar:ProgressBar = $chargeBar

##States in statemachine
enum SPEARSTATUS {
	ready,
	charging,
	thrown,
	returning
}

func _process(delta: float) -> void:

	oscillation_time += delta
	oscillation = sin(oscillation_time * oscillation_speed) * 0.5 + 0.5 #Calculates oscillation and offsets it
	chargeBar.value = oscillation * 100 #Sets percentage of progress bar

	#The state machine:
	match current_state:
		#FIXME: Add idle state and make it initial, so player needs to click to
		#take out spear and then the state progresses to ready
		SPEARSTATUS.ready:
			var mouse_pos = get_global_mouse_position()
			direction = (mouse_pos - global_position).normalized()
			sprite.rotation = direction.angle() - PI/2
			#Sprite is rotated to mouse and direction is set
			if Input.is_action_just_pressed("primary"):
				current_state = SPEARSTATUS.charging
				charging_start_rotation = direction.angle() - PI/2 # Store inital rotation
				chargeBar.visible = true
				var audio_player = Audio.play_sound_2d(soundReady, "Effects") #FIXME: Mismunandi hljóð fyrir ready og að byrja að charge-a
				audio_player.position = global_position

		SPEARSTATUS.charging: #Charging spear throw
			#Gamalt
			#var mouse_pos = get_global_mouse_position()
			#direction = (mouse_pos - global_position).normalized()
			#Adds wobble and wobbles more when poorly timed (not at peak charge)
			var wobble_intensity = wobble_amount * (1.0 - oscillation)
			var rotation_offset = sin(oscillation_time * oscillation_speed * wobble_speed_multiplier) * wobble_intensity
			sprite.rotation = charging_start_rotation + rotation_offset

			#FIXME: Add reduced sprite rotation to charging mode to make aiming harder and more natural
			if Input.is_action_just_released("primary"):
				chargeBar.visible = false
				useItem() 
				var audio_player = Audio.play_sound_2d(soundThrow, "Effects")
				audio_player.position = global_position

		SPEARSTATUS.thrown: 
			if Input.is_action_just_pressed("primary"): #Click again to reset
				resetItem()
				var audio_player = Audio.play_sound_2d(soundReady, "Effects")
				audio_player.position = global_position

func useItem() -> void: ##Spawn and fires a spearPhysics spear
	current_state = SPEARSTATUS.thrown
	sprite.visible = false
	spearChild = spearPhysics.instantiate()
	add_child(spearChild)
	spearChild.rotation = sprite.rotation
	spearChild.apply_impulse(direction * throw_force * 100 * oscillation) #FIXME: Remove magic number or make it a CONSTANT


func resetItem(): ##Removes spear and reset view of spear spawner
	current_state = SPEARSTATUS.ready
	spearChild.queue_free()
	spearChild = null
	sprite.visible = true

#FIXME: Make health part of the game?
func _on_health_component_health_zero() -> void:
	queue_free()
