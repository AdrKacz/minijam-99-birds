extends CenterContainer

onready var progress_bar : TextureProgress = $TextureProgress

func update_value(value):
	value = clamp(value, 1, 100)
	progress_bar.value = value
