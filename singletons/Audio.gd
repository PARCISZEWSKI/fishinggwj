# Full video: https://www.youtube.com/watch?v=OEpfdmW6_s0
# (c) Bryce Dixon, distributed under MIT License: https://github.com/BtheDestroyer/Godot_QuickAudio
@icon("./icon.svg")
extends Node2D

@onready var tree := get_tree() # Gets the slightest of performance improvements by caching the SceneTree

func _play_sound(sound: AudioStream, player, bus: String = "Master", autoplay := true):
  player.bus = bus
  player.stream = sound
  player.autoplay = autoplay
  player.finished.connect(func(): player.queue_free())
  self.add_child(player)

  return player

# Use this for non-diagetic music or UI sounds which have no position
func play_sound(sound: AudioStream,bus: String = "Master", autoplay := true) -> AudioStreamPlayer:
  return _play_sound(sound, AudioStreamPlayer.new(), bus, autoplay)

# Use this for 2D gameplay sounds which should fade with distance
# Note: Remember to set the global_position or reparent(new_parent, false)!
func play_sound_2d(sound: AudioStream,bus: String = "Master", autoplay := true) -> AudioStreamPlayer2D:
  return _play_sound(sound, AudioStreamPlayer2D.new(), bus, autoplay)

# Use this for 3D gameplay sounds which should fade with distance
# Note: Remember to set the global_position or reparent(new_parent, false)!
func play_sound_3d(sound: AudioStream,bus: String = "Master", autoplay := true) -> AudioStreamPlayer3D:
  return _play_sound(sound, AudioStreamPlayer3D.new(), bus, autoplay)
