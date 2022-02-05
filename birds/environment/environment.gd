extends Spatial


export (float, 1, 100) var speed : float = 20

export (int, 10, 100) var width : int = 35
export (int, 10, 100) var height : int = 25
export (PackedScene) var terrain_scene : PackedScene
export (Array, PackedScene) var rock_scenes : Array

var current_ground_A : bool = true

onready var ground_A : Spatial = $GroundA
onready var ground_B : Spatial = $GroundB

func _ready() -> void:
	ground_B.transform.origin.z = ground_A.transform.origin.z - width
	generate_environment(ground_A)
	generate_environment(ground_B)
	
func clear_environment(ground : Spatial) -> void:
	for node in ground.get_children():
		ground.remove_child(node)
		node.queue_free()
	
func generate_environment(ground : Spatial) -> void:
	# Generate Ground
	for i in range(width): # z
		for j in range(height): # x
			var coordinates : Vector3 = Vector3(-height / 2 + j, 0, - width / 2 + i)
			var terrain : Spatial = terrain_scene.instance()
			terrain.translate(coordinates)
			ground.add_child(terrain)
			
			# Add rocks with a probability p = 0.01
			if randf() < 0.01:
				var rock_index : int = randi() % rock_scenes.size()
				var rock : Spatial = rock_scenes[rock_index].instance()
				rock.translate(coordinates)
				ground.add_child(rock)
				
func _process(delta):
	ground_A.translate(Vector3(0, 0, 1 * delta * speed))
	ground_B.translate(Vector3(0, 0, 1 * delta * speed))
	
	if current_ground_A and ground_A.transform.origin.z > width + 1:
		ground_A.transform.origin.z = ground_B.transform.origin.z - width
#		clear_environment(ground_A)
#		generate_environment(ground_A)
		current_ground_A = false
	elif not current_ground_A and ground_B.transform.origin.z > width + 1:
		ground_B.transform.origin.z = ground_A.transform.origin.z - width
#		clear_environment(ground_B)
#		generate_environment(ground_B)
		current_ground_A = true

