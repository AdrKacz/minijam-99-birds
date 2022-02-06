extends Control

const menu_scene_path : String = "res://menu/menu.tscn"

onready var opacity_filter : ColorRect = $OpacityFilter
onready var label_container : MarginContainer = $LabelContainer
onready var menu_container : MarginContainer = $MenuContainer

func switch_pause() -> void:
	if get_tree().paused:
		opacity_filter.hide()
		label_container.hide()
		menu_container.hide()
	else:
		opacity_filter.show()
		label_container.show()
		menu_container.show()
	Game.pause_game(not get_tree().paused)

func _on_PauseButton_pressed() -> void:
	switch_pause()

func _on_MenuButton_pressed() -> void:
	Game.pause_game(false)
	Scene.goto_scene(menu_scene_path)


func _on_UnpauseButton_pressed():
	switch_pause()
