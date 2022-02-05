extends Node


onready var master_index : int = AudioServer.get_bus_index("Master")

func _ready():
	if OS.has_feature("web"):
		 set_is_mute(true)

func set_is_mute(is_mute : bool) -> void:
	AudioServer.set_bus_mute(master_index, is_mute)
