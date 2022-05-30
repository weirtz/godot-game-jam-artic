extends KinematicBody

const MOVE_SPEED_FACTOR = 2.5 #ball follow speed
const SPAWN_ENEMY_INTERVAL = 5.0

var cutscene_done = false
var velocity = Vector3()
var move_speed = 0.5
var target_translation
var moveToPlayer = true
var spawn_enemy_timer := 0.0
export var ball_drop_distance = 50
export var ball_drop_progress = 0.0
var rewind_secs = 0.0
var countdown_timer: float
var Enemy = preload ("res://scenes/NPC/groblen.tscn")

onready var secs_text_label: RichTextLabel = $Control/RichTextLabelSecs
onready var anim_ball_drop: AnimationPlayer = $AnimationPlayerBallDrop

# Called when the node enters the scene tree for the first time.
func _ready():
	GameManager.init_ball()

func didScienceFinish():
	cutscene_done = true
	moveToPlayer = true
	
	
	$AnimationPlayerBallDrop.play("Drop")
	$AnimationPlayerBallSpin.play("spin")
	target_translation = Vector3(0.0,translation.y,0.0)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#check to see if there is a cutscene, without this the ball will continue to move around and countdown.
	if cutscene_done:
		spawn_enemy_timer += delta
		#how fast to spawn enemies.
		if spawn_enemy_timer > SPAWN_ENEMY_INTERVAL:
			_spawn_enemy()
			spawn_enemy_timer = 0.0 #reset spawn timer

		#COUNTDOWN CLOCK
		countdown_timer = floor(anim_ball_drop.current_animation_length) - floor(anim_ball_drop.current_animation_position)
		secs_text_label.text = str(countdown_timer) + " Seconds"


		_process_move_ball_back_to()
		if Input.is_action_pressed("dev_add_time"):
			move_ball_back_secs(1.0)
		_set_ball_drop(ball_drop_progress)
		

		# Move towards player
		if moveToPlayer:
			move_speed = MOVE_SPEED_FACTOR * ball_drop_progress
			target_translation.x = get_parent().get_node("KinematicBody").translation.x
			target_translation.z = get_parent().get_node("KinematicBody").translation.z
			velocity = (target_translation-translation).normalized()*move_speed
			velocity = move_and_slide(velocity);

		#if less tahn or equal to 3 play lose sound on 0
		if countdown_timer == 3:
			if not $AudioStreamPlayer.playing:
				$AudioStreamPlayer.play()

		#trigger game lose and return to main menu.
		if countdown_timer <= 0:
			if not $"../KinematicBody/Audio/lose-effect".playing:
				$"../KinematicBody/Audio/lose-effect".play()
			if not $"../KinematicBody/Audio/lose".playing:
				$"../KinematicBody/Audio/lose".play()
			get_tree().get_root().get_node("Map").timer_main_menu()

#remove enemy instances and return to main menu/end screen
func gotoMainMenu():
	get_tree().call_group("enemy", "queue_free")
	get_tree().change_scene("res://scenes/menus/end.tscn")



#change wether the ball can move towards the player or not.
func setMoveToPlayer(statement: bool):
	moveToPlayer = statement

func _set_ball_drop(ball_drop_progress: float):
	
	var top_y = ball_drop_distance
	var bottom_y = ball_drop_distance - 1.5
	var ball_y = top_y - ball_drop_progress * bottom_y
	$Icosphere.translation.y = ball_y
	$Camera.translation.y = ball_y+3
	$CPUParticles.translation.y = ball_y
	$OmniLight.translation.y = ball_y

func move_ball_back_secs(secs: float):
	$AnimationPlayerBallDrop.playback_speed = 4.0
	rewind_secs = clamp($AnimationPlayerBallDrop.current_animation_position - secs, 0.0, $AnimationPlayerBallDrop.current_animation_length)
	$AnimationPlayerBallDrop.play_backwards("Drop")

func _process_move_ball_back_to():
	if $AnimationPlayerBallDrop.current_animation_position <= rewind_secs:
		$AnimationPlayerBallDrop.play("Drop")
		$AnimationPlayerBallDrop.playback_speed = 1.0

func _spawn_enemy():
	var ball_pos = get_node("Icosphere").global_transform.origin
	var e = Enemy.instance()
	get_tree().get_root().add_child(e)
	e.global_transform.origin = ball_pos

#gives the ability to pause the ball during cutscenes
#changes a bool to false and it will pause the ball for cutscene
func toggleCutscemePauser(run: bool):
	cutscene_done = run

#unload ball before going to main menu
func unloadBall():
	var ball = get_tree().get_root().get_node("/root/Map/Ball")
	ball.queue_free()

#play animation that will trigger win scene and trigger ball material change
func changeBallMaterial():
	var ball = get_tree().get_root().get_node("/root/Map/Ball")
	var ballWinAnim = get_tree().get_root().get_node("/root/Map/Ball/Camera/WinAnim")
	#start glow animation
	ballWinAnim.play("end-scene")

#change material of ball
func addBallMaterial():
	var ballMat = preload ("res://shaders/ball_material_shaders.tres")
	var ballMaterialChange = get_tree().get_root().get_node("/root/Map/Ball/Icosphere")
	ballMaterialChange.set_surface_material(0,ballMat)
