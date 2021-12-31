extends KinematicBody

var player_body
var velocity = Vector3()
var move_speed = 0.5
var target_translation
var is_flying = true
var normal_gravity = 7.6
var falling_gravity = 0.5
const MOVE_SPEED_FACTOR = 1.0
var hp = 1

onready var ground_ray_cast = get_node("RayCast")
onready var animation_player = get_node("AnimationPlayer")

func _ready():
	animation_player.play("FlyOut")


func _process(delta):
	if hp <= 0:
		queue_free()
	
	if not is_flying:
		# Move towards player
		move_speed = MOVE_SPEED_FACTOR
		target_translation.x = player_body.translation.x
		target_translation.z = player_body.translation.z
		var tmp_velocity = (target_translation-translation).normalized()*move_speed
		velocity.x = tmp_velocity.x
		velocity.z = tmp_velocity.z
		velocity.y -= normal_gravity * delta
		
		look_at(target_translation, Vector3.UP)
	else:
		velocity.y -= falling_gravity * delta
		
	velocity = move_and_slide(velocity, Vector3.UP)

	if velocity.y == 0.0:
		_start_chasing()


func _start_chasing():
	if is_flying:
		animation_player.play("GrobWalk")
		player_body = get_tree().get_root().get_node("Map/KinematicBody")
		target_translation = Vector3(0.0,translation.y,0.0)
		
	is_flying = false


func _start_flying():
	if not is_flying:
		animation_player.play("FlyOut")
	is_flying = true


func _on_Area_body_entered(body):
	if body.name == "KinematicBody":
		_attack_player()
	
	if "Ground" in body.get_parent().name:
		_start_chasing()


func _on_Area_body_exited(body):
	if body.get_parent().name == "KinematicBody":
		animation_player.play("GrobWalk")


func _attack_player():
	animation_player.play("NoseAttack")
	var player = get_tree().get_root().get_node("Map/KinematicBody")
	player.stunned_by_groblen()
