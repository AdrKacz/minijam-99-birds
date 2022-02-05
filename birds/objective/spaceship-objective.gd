extends Spatial

signal validated
signal unvalidated

func _on_ValidatedArea_body_entered(body):
	emit_signal("validated")

func _on_ValidatedArea_body_exited(body):
	emit_signal("unvalidated")
