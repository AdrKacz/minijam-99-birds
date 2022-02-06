extends Control

const menu_scene_path : String = "res://menu/menu.tscn"

func _on_MenuButton_pressed():
	Scene.goto_scene(menu_scene_path)
