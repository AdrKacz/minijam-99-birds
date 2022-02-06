extends AudioStreamPlayer

var last_playback_position : int = 0

func switch_pause_music() -> void:
	if playing:
		last_playback_position = get_playback_position()
		stop()
	else:
		play(last_playback_position)
