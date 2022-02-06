extends Control

signal return_to_menu

onready var music_button : Button = $ButtonContainer/CenterContainer/VBoxContainer/MusicButton

func _ready():
	if AudioStreamMain.playing:
		music_button.text = "Turn off music background"
	else:
		music_button.text = "Turn on music background"

func _on_MenuButton_pressed():
	emit_signal("return_to_menu")

func _on_MusicButton_pressed():
	if AudioStreamMain.playing:
		music_button.text = "Turn on music background"
	else:
		music_button.text = "Turn off music background"
	AudioStreamMain.switch_pause_music()
