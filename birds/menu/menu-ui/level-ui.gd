extends Control

signal return_to_menu
signal goto_level(level)

onready var grid_container : GridContainer = $LevelContainer/CenterContainer/GridContainer

func _ready():
	var i : int = 0
	for button in grid_container.get_children():
		if i < Game.level_max_succeeded:
			button.disabled = false
		i += 1

func _on_Button_pressed():
	emit_signal("return_to_menu")


func _on_Level_pressed(level):
	emit_signal("goto_level", level)
