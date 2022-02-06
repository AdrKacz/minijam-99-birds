extends Node

var is_paused : bool = false

func pause_game(is_paused : bool):
	get_tree().paused = is_paused
	
var is_gaming : bool = false

var current_level : int = 0

# First spaceship is the active one
const levels : Array = [
	{
		"spaceships": [
			Vector3(0, 0, 0),
		],
		"objectives": [
			Vector3(0, 0, 0),
		],
		"help": "Use your space bar"
	},
	{
		"spaceships": [
			Vector3(0, 0, 0),
		],
		"objectives": [
			Vector3(0, 0, 0)
		],
		"help": ""
	},
	{
		"spaceships": [
			Vector3(0, 0, 0),
		],
		"objectives": [
			Vector3(5, 0, 0)
		],
		"help": ""
	},
]

#	{
#		"spaceships": [
#			Vector3(0, 0, 0),
#			Vector3(0, 0, 5),
#			Vector3(5, 0, 5),
#			Vector3(0, 0, 10),
#		],
#		"objectives": [
#			Vector3(0, 0, 0),
#			Vector3(0, 0, 5),
#			Vector3(0, 0, 10),
#			Vector3(-5, 0, 5),
#		]
#	}
