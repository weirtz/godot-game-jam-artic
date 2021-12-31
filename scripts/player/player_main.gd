extends KinematicBody
class_name PlayerMain

const STUN_TIME = 5.0

#--------------------
# General 
var camera_change = Vector2()
var tween
#--------------------
# Mouse
var mouse_sensitivity = 1
var camera_angle = 0

#--------------------
# Inventory
var inventory_resource = load("res://scripts/player/inventory.gd")
var inventory = inventory_resource.new()
onready var movement = $PlayerMovement/Movement

#--------------------
# Functions
func _ready():
	pass


func _input(event):
	if event is InputEventMouseMotion:
		camera_change = event.relative


func aim():
	if camera_change.length() > 0 :
		rotate_y(deg2rad(-camera_change.x * mouse_sensitivity))
		var change = -camera_change.y * mouse_sensitivity
		if change + camera_angle < 90 and change + camera_angle > -90:
			$PlayerCamera.rotate_x(deg2rad(change))
			camera_angle += change
		camera_change = Vector2()


func _physics_process(delta):
	#Initiate Player
	aim()
	$"GUI/console".console()

	tween = $"PlayerCamera/FovTween"
	#Flying Toggle
	if Input.is_action_just_pressed("fly"):
		$PlayerMovement/Fly.flying = !$PlayerMovement/Fly.flying
		$HitBox.visible = !$HitBox.visible
	if $PlayerMovement/Fly.flying:
		$PlayerMovement/Movement.speed = $PlayerMovement/Movement.MAX_SPEED
		
		tween.interpolate_property($"PlayerCamera", "fov", $"PlayerCamera".fov, $"PlayerMovement/Movement".fovDefault, 0.1, Tween.TRANS_LINEAR, Tween.EASE_OUT)
		tween.start()
		
		$PlayerMovement/Fly.fly(delta)
	else:
		$PlayerMovement/Movement.walk(delta)
	
func setWeaponInHand(value):
	if value == true:
		$PlayerCamera/Hand.visible = true
	if value == false:
		$PlayerCamera/Hand.visible = false


func stunned_by_groblen():
	print("stunned")
	movement.stamina_bar.set_timed_walk_override(STUN_TIME)
