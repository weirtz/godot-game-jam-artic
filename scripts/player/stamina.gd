extends ProgressBar


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var runningLockOut : = false 

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
		
func _process(delta):
	
	#control the progress bar when sprinting
	if $"../../../PlayerMovement/Movement".running == true:
		value -= 10*delta
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
		runningLockOut = false
		$"../RunningLockAnim".stop()
		visible = true

		
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
