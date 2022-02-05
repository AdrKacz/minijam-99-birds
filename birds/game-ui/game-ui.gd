extends Control


var progress : float = 0

onready var progress_bar_container : CenterContainer = $MarginContainer/ProgressBarContainer
onready var count_down_container : CenterContainer = $CountDownContainer
onready var count_down_label : Label = $CountDownContainer/CountDownMeta/Label

onready var level_container : MarginContainer = $LevelContainer
onready var level_label : Label = $LevelContainer/CenterContainer/Label

onready var count_down_animation_player : AnimationPlayer = $CountDownContainer/AnimationPlayer
onready var level_animation_player : AnimationPlayer = $LevelContainer/AnimationPlayer

func _process(delta) -> void:
	progress_bar_container.update_value(progress)
	
func set_count_down(value : int):
	count_down_container.show()
	count_down_label.text = str(value)
	count_down_animation_player.play("count_down")
	
func set_level(value : int):
	level_animation_player.play("level_in")
	level_label.text = "Level %d" % value
	level_container.show()
	
func hide_count_down():
	count_down_container.hide()


func _on_AnimationPlayer_animation_finished(anim_name):
	level_container.hide()
