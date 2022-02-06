extends CenterContainer

onready var progress_bar : TextureProgress = $TextureProgress
onready var tween : Tween = $Tween

var progress_value : float = 1 # between 1 and 100

func _process(_delta):
	progress_bar.value = progress_value

func update_value(value):
	value = clamp(value, 1, 100)
	var animation_time : float = stepify(abs(progress_value - value) / 100, 0.01)
	tween.interpolate_property(self, "progress_value", progress_value, value, animation_time)
	if not tween.is_active():
		tween.start()
