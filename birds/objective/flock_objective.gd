extends Spatial

signal validated
signal unvalidated

export (PackedScene) var objective_scene : PackedScene

var number_of_objectives : int = 0
var number_of_objectives_validated : int = 0

onready var flock : Spatial = $Flock


func reset_objectives() -> void:
	for objective in flock.get_children():
		flock.remove_child(objective)
		objective.queue_free()
		
	number_of_objectives = 0
	number_of_objectives_validated = 0
	for objective_position in Game.levels[Game.current_level].objectives:
		var objective : Spatial = objective_scene.instance()
		objective.translate(objective_position)
		flock.add_child(objective)
		number_of_objectives += 1
		objective.connect("validated", self, "_on_Objective_Validated", [objective.get_name()])
		objective.connect("unvalidated", self, "_on_Objective_Unvalidated", [objective.get_name()])

func _on_Objective_Validated(objective_name) -> void:
	number_of_objectives_validated += 1
	if number_of_objectives_validated == number_of_objectives:
		emit_signal("validated") 

func _on_Objective_Unvalidated(objective_name) -> void:
	number_of_objectives_validated -= 1
	if number_of_objectives_validated == number_of_objectives - 1:
		emit_signal("unvalidated") 
		
