extends Control


var progress : float = 0

onready var progress_bar_container : CenterContainer = $MarginContainer/ProgressBarContainer
onready var count_down_container : CenterContainer = $CountDownContainer
onready var count_down_label : Label = $CountDownContainer/CountDownMeta/Label
onready var count_down_animation_player : AnimationPlayer = $CountDownContainer/AnimationPlayer

func _process(delta) -> void:
	progress_bar_container.update_value(progress)
	
func set_count_down(value):
	count_down_container.show()
	count_down_label.text = str(value)
	count_down_animation_player.play("count_down")
	
func hide_count_down():
	count_down_container.hide()
