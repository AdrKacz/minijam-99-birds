extends Spatial

signal validated
signal unvalidated


var number_of_objectives : int = 0
var number_of_objectives_validated : int = 0

onready var flock : Spatial = $Flock

func _ready() -> void:
	number_of_objectives = 0
	number_of_objectives_validated = 0
	for objective in flock.get_children():
		number_of_objectives += 1
		objective.connect("validated", self, "_on_Objective_Validated", [objective.get_name()])
		objective.connect("unvalidated", self, "_on_Objective_Unalidated", [objective.get_name()])

func _on_Objective_Validated(objective_name) -> void:
	number_of_objectives_validated += 1
	if number_of_objectives_validated == number_of_objectives:
		emit_signal("validated") 

func _on_Objective_Unalidated(objective_name) -> void:
	number_of_objectives_validated -= 1
	if number_of_objectives_validated == number_of_objectives - 1:
		emit_signal("unvalidated") 
		
