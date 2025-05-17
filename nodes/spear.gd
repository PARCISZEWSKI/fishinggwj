extends Node2D

@export_group("Customizable variable")
@export var throw_force: float = 105 ##Force spear is throw with
@export var spearPhysics: PackedScene ##Scene to be loaded
@export var oscillation_speed: float = PI/2.0 ##Bigger number -> faster
@export var soundReady: AudioStream
@export var soundThrow: AudioStream

var direction: Vector2 ##Direction to mouseposition
var current_state: SPEARSTATUS = SPEARSTATUS.ready ##Current state in statemachine
var spearChild: RigidBody2D ##Reference to spawned physics spear
var oscillation_time: float = 0.0 ##Tracks project time #FIXME: need to be reset once in a while, isn't currently
var oscillation: float ##Output oscillation between [0, 1]
var MAX_LEFT_ANGLE = deg_to_rad(-60) #60 degrees left
var MAX_RIGHT_ANGLE = deg_to_rad(60) #60 degrees right

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
				chargeBar.visible = true
				var audio_player = Audio.play_sound_2d(soundReady, "Effects") #FIXME: Mismunandi hljóð fyrir ready og að byrja að charge-a
				audio_player.position = global_position

		SPEARSTATUS.charging: #Charging spear throw
			var mouse_pos = get_global_mouse_position()
			direction = (mouse_pos - global_position).normalized()
			#Calculate target angle with constraints
			var raw_angle = direction.angle() - PI/2
			var target_angle = clamp(raw_angle, MAX_LEFT_ANGLE, MAX_RIGHT_ANGLE)
			#Apply damped rotation
			sprite.rotation = target_angle

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
