extends AudioStreamPlayer

var target_pitch = 1.0

func _process(delta):
	if pitch_scale != target_pitch:
		set_pitch_scale(lerp(pitch_scale, target_pitch, delta * 2))

func is_bgm_enabled():
	return !AudioServer.is_bus_mute(AudioServer.get_bus_index("BGM"))

func set_bgm_enabled(enabled):
	AudioServer.set_bus_mute(AudioServer.get_bus_index("BGM"), !enabled)

func is_sfx_enabled():
	return !AudioServer.is_bus_mute(AudioServer.get_bus_index("SFX"))
	
func set_sfx_enabled(enabled):
	AudioServer.set_bus_mute(AudioServer.get_bus_index("SFX"), !enabled)

func change_pitch(pitch):
	target_pitch = pitch
