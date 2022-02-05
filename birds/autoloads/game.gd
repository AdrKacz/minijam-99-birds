extends Node

var is_gaming : bool = false

var current_level : int = 0

# First spaceship is the active one
const levels : Array = [
	{
		"spaceships": [
			Vector3(0, 0, 0),
			Vector3(0, 0, 5),
		],
		"objectives": [
			Vector3(5, 0, 0),
			Vector3(-5, 0, 5),
		]
	},
	{
		"spaceships": [
			Vector3(0, 0, 0),
		],
		"objectives": [
			Vector3(0, 0, 0)
		]
	},
	{
		"spaceships": [
			Vector3(0, 0, 0),
		],
		"objectives": [
			Vector3(5, 0, 0)
		]
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
