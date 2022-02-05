extends Spatial

signal validated
signal started

export (float, 1, 5) var max_level_time : float = 3

var count_down_value : int = 3
var level_time : float = 0
var is_validated : bool = false

onready var game_ui : Control = $GameUI
onready var timer_count_down : Timer = $TimerCountDown
onready var timer_start : Timer = $TimerStart
onready var flock_controller : Spatial = $FlockController
onready var flock_objective : Spatial = $FlockObjective
onready var flock_animation_player : AnimationPlayer = $FlockAnimation

func _ready():
	start_level()
	
func start_level() -> void:
	flock_controller.reset_spaceships()
	flock_objective.reset_objectives()
	level_time = 0
	game_ui.progress = 1
	count_down_value = 3
	is_validated = false
	timer_start.start()

func continue_start_level() -> void:
	flock_in()
	flock_objective.show()
	game_ui.set_level(Game.current_level + 1)
	count_down()
	
func end_level() -> void:
	Game.is_gaming = false
	flock_controller.reset_force_spaceships()
	flock_out()
	flock_objective.hide()

func validate_level() -> void:
	end_level()
	Game.current_level += 1
	emit_signal("validated")
	
func flock_in():
	flock_animation_player.play("flock_in")
	
func flock_out():
	flock_animation_player.play("flock_out")

func count_down() -> void:
	if count_down_value > 0:
		game_ui.set_count_down(count_down_value)
		count_down_value -= 1
		timer_count_down.start()
	elif count_down_value == 0:
		game_ui.hide_count_down()
		Game.is_gaming = true
		emit_signal("started")

func _process(delta):
	if not Game.is_gaming:
		return
	if is_validated:
		level_time += delta
	else:
		level_time -= delta
	game_ui.progress = 1 + level_time / max_level_time * 99 # progress between 1 and 100
	if level_time > max_level_time:
		validate_level()
	level_time = clamp(level_time, 0, max_level_time)

func _on_FlockObjective_validated() -> void:
	is_validated = true

func _on_FlockObjective_unvalidated() -> void:
	is_validated = false

func _on_FlockAnimation_animation_finished(anim_name):
	if anim_name == "flock_out":
		start_level()


func _on_TimerCountDown_timeout():
	count_down()

func _on_TimerStart_timeout():
	# Extra time to create level
	continue_start_level()

func _on_FlockController_exploded():
	end_level()
