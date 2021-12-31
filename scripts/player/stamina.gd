extends ProgressBar


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var runningLockOut : = false 
signal replenished

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _process(delta):
	
	#control the progress bar when sprinting
	if $"../../../PlayerMovement/Movement".running == true:
		value -= 5*delta
	else:
		if value <= 100:
			value += 1*delta*10

	#stop player from using run, if stamina hits 0
	if value <= 0:
		runningLockOut = true
		#change speed to walking when stamina hits 0
		$"../../../PlayerMovement/Movement".speed = $"../../../PlayerMovement/Movement".MAX_SPEED
		$"../../../PlayerMovement/Movement".tween.interpolate_property($"../../../PlayerCamera", "fov", $"../../../PlayerCamera".fov, $"../../../PlayerMovement/Movement".fovDefault, 0.1, Tween.TRANS_LINEAR, Tween.EASE_OUT)
		$"../../../PlayerMovement/Movement".tween.start()
		$"../../../PlayerMovement/Movement".running = false
		
		$"../RunningLockAnim".play("runningLock")
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
