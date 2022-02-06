extends Control

const game_scene_path : String = "res://game/game.tscn"

onready var level_ui : Control = $LevelUI
onready var title_container : MarginContainer = $TitleContainer
onready var button_container : MarginContainer = $ButtonContainer


func _ready():
	Game.is_gaming = false

func _on_StartButton_pressed():
	Game.current_level = 0
	Scene.goto_scene(game_scene_path)

func _on_LevelButton_pressed():
	title_container.hide()
	button_container.hide()
	level_ui.show()


func _on_LevelUI_goto_level(level):
	Game.current_level = level - 1
	Scene.goto_scene(game_scene_path)


func _on_LevelUI_return_to_menu():
	level_ui.hide()
	title_container.show()
	button_container.show()
