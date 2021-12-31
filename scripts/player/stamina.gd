extends ProgressBar


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var walk_override := false
var walk_override_timer := 0.0
var walk_override_time := 0.0

var runningLockOut : = false 
signal replenished

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _process(delta):
	# Handle walk override if it is active
	if walk_override:
		if walk_override_timer == 0.0:
			_run_lock()
		walk_override_timer += delta;
		if walk_override_timer >= walk_override_time:
			_run_unlock()
			walk_override = false
			walk_override_timer = 0.0
		return

	#control the progress bar when sprinting
	if $"../../../PlayerMovement/Movement".running == true:
		value -= 5*delta
	else:
		if value <= 100:
			value += 1*delta*10

	#stop player from using run, if stamina hits 0
	if value <= 0:
		#change speed to walking when stamina hits 0
		_run_lock()
	if value >= 100:
		_replenished(false)


func increase_stamina(stamina: float):
	value += stamina
	_replenished(true)


func _replenished(immediate_sprint: float):
	runningLockOut = false
	$"../RunningLockAnim".stop()
	visible = true
	if immediate_sprint:
		emit_signal("replenished")


func _run_lock():
	runningLockOut = true
	
	$"../../../PlayerMovement/Movement".speed = $"../../../PlayerMovement/Movement".MAX_SPEED
	$"../../../PlayerMovement/Movement".tween.interpolate_property($"../../../PlayerCamera", "fov", $"../../../PlayerCamera".fov, $"../../../PlayerMovement/Movement".fovDefault, 0.1, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	$"../../../PlayerMovement/Movement".tween.start()
	$"../../../PlayerMovement/Movement".running = false
	$"../RunningLockAnim".play("runningLock")


func  _run_unlock():
	runningLockOut = false
	_replenished(true)


func set_timed_walk_override(time: float):
	walk_override_time = time
	walk_override = true
