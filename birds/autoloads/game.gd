extends Node

var is_paused : bool = false

func pause_game(is_paused : bool):
	get_tree().paused = is_paused
	
var is_gaming : bool = false

var current_level : int = 0
var level_max_succeeded : int = 1

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
			Vector3(0, 0, 5),
		],
		"objectives": [
			Vector3(5, 0, 0),
			Vector3(4, 0, 5)
		],
		"help": "Spaceships follow\nyour green aura"
	},
	{
		"spaceships": [
			Vector3(0, 0, 0),
			Vector3(0, 0, 5),
		],
		"objectives": [
			Vector3(5, 0, 0),
			Vector3(-5, 0, 5),
		],
		"help": "Click on a spaceship\nto move your aura\n\nTry to alternate\nbetween spaceships..."
	},
	{
		"spaceships": [
			Vector3(-3, 0, 0),
			Vector3(3, 0, 0),
		],
		"objectives": [
			Vector3(6, 0, 0),
			Vector3(-6, 0, 0),
		],
		"help": "Be cool, don't crash"
	},
	{
		"spaceships": [
			Vector3(0, 0, 5),
			Vector3(0, 0, 0),
			Vector3(0, 0, 10),
		],
		"objectives": [
			Vector3(5, 0, 0),
			Vector3(0, 0, 5),
			Vector3(-5, 0, 10),
		],
		"help": "So, you're the\nnew flock master?\n\nShow me your talent!"
	},
	{
		"spaceships": [
			Vector3(-3, 0, 0),
			Vector3(3, 0, 0),
			Vector3(-3, 0, 5),
			Vector3(3, 0, 5),
		],
		"objectives": [
			Vector3(0, 0, 0),
			Vector3(6, 0, 0),
			Vector3(0, 0, 5),
			Vector3(-6, 0, 5),
		],
		"help": "Queen Madrilla II\nloves how birds fly!\n\nBut you know...\nNo bird on Mars"
	},
	{
		"spaceships": [
			Vector3(-6, 0, 0),
			Vector3(-2, 0, 0),
			Vector3(2, 0, 5),
			Vector3(6, 0, 10),
		],
		"objectives": [
			Vector3(-6, 0, 0),
			Vector3(6, 0, 0),
			Vector3(-6, 0, 5),
			Vector3(-6, 0, 10),
		],
		"help": "It's her birthday tomorrow\nDon't disappoint her!"
	},
	{
		"spaceships": [
			Vector3(2, 0, 10),
			Vector3(0, 0, 0),
			Vector3(-6, 0, 5),
			Vector3(-2, 0, 5),
			Vector3(6, 0, 10),
			Vector3(0, 0, 15),
		],
		"objectives": [
			Vector3(0, 0, 0),
			Vector3(2, 0, 5),
			Vector3(-2, 0, 5),
			Vector3(-6, 0, 10),
			Vector3(6, 0, 10),
			Vector3(0, 0, 15),
		],
		"help": "Do you know birds were\nflying without Quant Energy?"
	},
	{
		"spaceships": [
			Vector3(6, 0, 10),
			Vector3(0, 0, 0),
			Vector3(2, 0, 5),
			Vector3(6, 0, 5),
			Vector3(-6, 0, 10),
			Vector3(2, 0, 10),
			Vector3(0, 0, 15),
			Vector3(4, 0, 15),
		],
		"objectives": [
			Vector3(0, 0, 0),
			Vector3(-2, 0, 5),
			Vector3(2, 0, 5),
			Vector3(4, 0, 10),
			Vector3(0, 0, 10),
			Vector3(-4, 0, 10),
			Vector3(-6, 0, 15),
			Vector3(6, 0, 15),
		],
		"help": "Here's your flock\nfor tomorrow\n\nYou proved you can do it\nGood luck master!"
	},
]
