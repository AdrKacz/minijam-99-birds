extends Control

const game_scene_path : String = "res://game/game.tscn"

func _on_StartButton_pressed():
	Scene.goto_scene(game_scene_path)
