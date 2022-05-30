extends Spatial
var timer = 0
var wait_time = 3
var goNow = false
var scienceScene = true
var cutscene_done2 = false
var mainMenuOver = false

#disables editor light
func _ready():
	$EDITOR_LIGHT.visible = false
	
func _process(delta):
	if Input.is_action_just_pressed("test-enemy"):
		spawn_enemy()
	if goNow == true:
		timer+=delta
		if timer>wait_time:
			execute_menu_change()
	
	if Input.is_action_just_pressed("move_jump") and scienceScene == true and mainMenuOver == true:
		$Cameras/Camera1/screen_text.visible = false
		$Cameras/Camera2/screen_text.visible = false
		$Cameras/Camera3/screen_text.visible = false
		$Cameras/Camera4/screen_text.visible = false
		$Cameras/Camera5/screen_text.visible = false
		$Cameras/Camera6/screen_text.visible = false
		$Cameras/AnimationPlayerCameras.stop()
		$Cameras.cameraSelect(7)
		
#-----------------------------------
# SPAWNING ENEMIES
		
var Enemy = preload ("res://scenes/NPC/groblen.tscn")

func scienceSceneToggle(state: bool):
	scienceScene = state

func mainMenuOver(state: bool):
	mainMenuOver = state

func spawn_enemy():
	var ballPOS = get_tree().get_root().get_node("/root/Map/Ball/Icosphere")
	var e = Enemy.instance()
	var pos = ballPOS.global_transform.origin
	add_child(e)
	e.global_transform.origin = pos

func timer_main_menu():
	#var timer = get_node("Timer")
	#timer.start()
	goNow = true;
	
func execute_menu_change():
	get_tree().call_group("enemy", "queue_free")
	$Ball.queue_free()
	get_tree().change_scene("res://scenes/menus/end.tscn")

func _on_Timer_timeout():
	$Timer.stop()
	print("timeout")
	get_tree().call_group("enemy", "queue_free")
	$Ball.queue_free()
	get_tree().change_scene("res://scenes/menus/end.tscn")
