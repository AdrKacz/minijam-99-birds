extends Spatial

signal exploded

export (float, 1, 10) var epsilon_degrees : float = 10

export (float, 0.5, 5) var rotation_speed : float = 1
export (float, 0, 90) var max_rotate_angle_degrees : float = 45
export (float, -10, 10) var rotate_force  : float = 0

var rotate_angle_target_radians : float = 0

onready var animation_player : AnimationPlayer = $AnimationPlayer
onready var selection_marker : Spatial = $Inner/Marker
onready var selection_selected : Spatial = $Inner/Selected

onready var audio_explosion : AudioStreamPlayer3D = $AudioExplosion
onready var audio_engine : AudioStreamPlayer3D = $AudioEngine

onready var epsilon_radians : float = deg2rad(epsilon_degrees)

func set_rotate_force(new_rotate_force : float) -> void:
	rotate_force = new_rotate_force
	var scaled_rotate_force : float = clamp((1 + rotate_force) / 2, 0, 1)
	rotate_angle_target_radians = deg2rad(lerp(-max_rotate_angle_degrees, +max_rotate_angle_degrees, scaled_rotate_force))
	
func _process(delta : float) -> void:
	var delta_rotation : float = abs(rotation.z - rotate_angle_target_radians)
	if delta_rotation > epsilon_radians:
		rotation.z = lerp_angle(rotation.z, rotate_angle_target_radians, delta * rotation_speed)
	if global_transform.origin.z < -20 and audio_engine.playing:
		audio_engine.stop()
		
func explode() -> void:
	animation_player.play("explode")

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "explode":
		emit_signal("exploded")
