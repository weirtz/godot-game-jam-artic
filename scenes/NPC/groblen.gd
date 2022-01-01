extends RigidBody

var player_body
var velocity = Vector3()
var move_speed = 100
var target_translation
var is_flying = true
var out_of_anim = true
var hp = 1
var turnSpeed = 5000
var playerLoc = Vector3()
var grobLoc = Vector3()

onready var ground_ray_cast = get_node("RayCast")
onready var animation_player = get_node("AnimationPlayer")
onready var area = get_node("Area")
onready var metar = get_node("metarig")

func _ready():
	animation_player.play("FlyOut")
	player_body = get_tree().get_root().get_node("Map/KinematicBody")
	target_translation = Vector3(0.0,translation.y,0.0)


func _process(delta):
	
	if hp <= 0:
		metar._disable_turn()
		out_of_anim = false;
		#print (out_of_anim)
		animation_player.play("GrobDIE");
		if animation_player.current_animation_position >= animation_player.current_animation_length - 0.05:
			queue_free()
	else:
		playerLoc.x = player_body.translation.x
		playerLoc.y = 0
		playerLoc.z = player_body.translation.z
		grobLoc.x = translation.x
		grobLoc.y = 0
		grobLoc.z = translation.z
		
		
		add_central_force((playerLoc - grobLoc).normalized() * delta * move_speed)
		
		if out_of_anim:
			#print (linear_velocity.y)
			if (linear_velocity.y >= -0.5):
				animation_player.play("GrobWalk")
				move_speed = 200
			else:
				animation_player.play("FlyOut")
				move_speed = 30
				
		else:
			if (animation_player.current_animation == "NoseAttack" and 0.8 <= animation_player.current_animation_position and animation_player.current_animation_position <= 0.806):
				_attack_player();
			elif (animation_player.current_animation == "NoseAttack" and animation_player.current_animation_position >= animation_player.current_animation_length - 0.01):
				out_of_anim = true
				#print (out_of_anim)

func _on_Area_body_entered(body):
	if body.name == "KinematicBody":
		out_of_anim = false
		#print(out_of_anim)
		animation_player.play("NoseAttack")


func _attack_player():
	var player = get_tree().get_root().get_node("Map/KinematicBody")
	if (area.overlaps_body(player)):
		player.stunned_by_groblen()
