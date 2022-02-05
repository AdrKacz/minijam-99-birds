extends MarginContainer


onready var on_container : CenterContainer = $OnContainer
onready var off_container : CenterContainer = $OffContainer

func _ready():
	if AudioServer.is_bus_mute(Sound.master_index):
		off_container.hide()
	else:
		on_container.hide()

func _on_OnButton_pressed():
	Sound.set_is_mute(false)
	off_container.show()
	on_container.hide()

func _on_OffButton_pressed():
	Sound.set_is_mute(true)
	on_container.show()
	off_container.hide()
