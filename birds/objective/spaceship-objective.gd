extends Spatial

signal validated
signal unvalidated

func _on_ValidatedArea_area_entered(area):
	emit_signal("validated")

func _on_ValidatedArea_area_exited(area):
	emit_signal("unvalidated")
