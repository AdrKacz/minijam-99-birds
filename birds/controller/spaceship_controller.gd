extends KinematicBody

signal exploded
signal activated

export (int, 10, 100) var height : float = 25
export (float, 1, 10) var acceleration : float = 5
export (float, 1, 10) var max_speed : float = 5
export (bool) var is_activated : bool = false 

onready var spaceship_mesh : Spatial = $Spaceship
onready var explosition_timer : Timer = $Explosion

var direction : Vector3 = Vector3()
var velocity : Vector3 = Vector3()
var target_direction_x : float = 0

var is_exploding : bool = false
var is_hovered : bool = false


func _ready():
	if is_activated:
		activate()

func explode() -> void:
	is_exploding = true
	emit_signal("exploded")
	# Start timer
	explosition_timer.start()
	
func activate() -> void:
	is_activated = true
	spaceship_mesh.selection_selected.show()
	
func deactivate() -> void:
	is_activated = false
	spaceship_mesh.selection_selected.hide()

func _physics_process(delta : float) -> void:
	if not Game.is_gaming or is_exploding:
		return
	process_boundaries()
	if is_activated:
		process_input()
	else:
		process_unactive()
	process_movement(delta)
	process_animation()
	
	if is_hovered and Input.is_action_just_released("select"):
		emit_signal("activated")

func process_boundaries() -> void:
	if transform.origin.x < - height / 2 + 2 or transform.origin.x > height / 2 - 2:
		explode()

func process_input() -> void:
	direction = Vector3()
	if Input.is_action_pressed("action"):
		direction.x -= 1
	else:
		direction.x += 1
	
# TODO: Change this bad name
func process_unactive() -> void:
	direction = Vector3()
	direction.x = target_direction_x
	
func process_movement(delta : float) -> void:
	var vertical_velocity : Vector3 = velocity
	vertical_velocity.z = 0
	vertical_velocity.y = 0
	
	var target : Vector3 = direction * max_speed
	
	vertical_velocity = vertical_velocity.linear_interpolate(target, acceleration * delta)
	velocity.x = vertical_velocity.x
	velocity = move_and_slide(velocity)
	
func set_rotate_force(value):
	spaceship_mesh.set_rotate_force(clamp(value, -1, 1))
	
func process_animation() -> void:
	if velocity.x > 0:
		spaceship_mesh.set_rotate_force(-1)
	elif velocity.x < 0:
		spaceship_mesh.set_rotate_force(+1)
	else:
		spaceship_mesh.set_rotate_force(0)

func _on_Explosion_timeout() -> void:
	queue_free()

func _on_CollisionDetector_area_entered(area):
	explode()

func _on_SelectionDetect_mouse_entered():
	is_hovered = true
	spaceship_mesh.selection_marker.show()

func _on_SelectionDetect_mouse_exited():
	is_hovered = false
	spaceship_mesh.selection_marker.hide()
