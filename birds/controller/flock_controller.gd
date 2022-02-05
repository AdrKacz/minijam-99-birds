extends Spatial

export (float, 0, 1) var min_ratio : float = 0
export (float, 0, 1) var max_ratio : float = 1
export (float) var min_distance : float = 0
export (float) var max_distance : float = 20

export (float, -1, 1) var a_parameter : float = 0

var activated_spaceship : Spatial

onready var flock : Spatial = $Flock

onready var b_parameter  : float = (min_ratio - max_ratio) / (max_distance - min_distance) 
onready var c_parameter : float = (max_distance * max_ratio - min_distance * min_ratio) / (max_distance - min_distance)

func _ready():
	activated_spaceship = $Flock/ActiveSpaceship
	for spaceship in flock.get_children():
		spaceship.connect("exploded", self, "_on_Spaceship_Exploded", [spaceship.get_name()])
		spaceship.connect("activated", self, "_on_Spaceship_Activated", [spaceship])
	
func _physics_process(delta) -> void:
	process_unactive_spaceships()
	
func reset_force_spaceships() -> void:
	if Game.is_gaming: # Don't perturbate game with animation
		return
	for spaceship in flock.get_children():
		spaceship.set_rotate_force(0)

func process_unactive_spaceships() -> void:
	if not activated_spaceship: # To avoid bug
		return
	var activated_origin_xz : Vector3 = activated_spaceship.transform.origin
	activated_origin_xz.y = 0
	var activated_velocity_ratio_x : float = activated_spaceship.velocity.x / activated_spaceship.max_speed
	
	for spaceship in flock.get_children():
		if spaceship.get_name() != activated_spaceship.get_name():
			var spaceship_origin_xz : Vector3 = spaceship.transform.origin
			spaceship_origin_xz.y = 0
			var distance : float = activated_origin_xz.distance_to(spaceship_origin_xz)
			distance = clamp(distance, min_distance, max_distance)
			var velocity_ratio : float = b_parameter * distance + c_parameter
			spaceship.target_direction_x = activated_velocity_ratio_x * velocity_ratio

func set_activated_spaceship(spaceship : Spatial):
	if activated_spaceship and activated_spaceship.get_name() == spaceship.get_name():
		return
	if activated_spaceship:
		 activated_spaceship.deactivate()
	spaceship.activate()
	activated_spaceship = spaceship
	
func _on_Spaceship_Exploded(spaceship_name):
	if activated_spaceship and spaceship_name == activated_spaceship.get_name():
		activated_spaceship = null
		
func _on_Spaceship_Activated(spaceship):
	set_activated_spaceship(spaceship)
