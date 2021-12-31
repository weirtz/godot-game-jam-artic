extends Spatial

onready var anim = $"bottleblaster/shoot-animation"
onready var animReload = $"bottleblaster/AnimationPlayer"
onready var ray = $"../RayCastWeapon"
var weaponWait = false

func _input(event):
	if Input.is_action_just_pressed("shoot") and weaponWait == false:
		anim.play("shoot")
		animReload.play("shake")
		print("shot")
		fire()

#fire function is called in the 'shoot-animation' AnimationPlayer
func fire():
	if ray.get_collider() != null and ray.get_collider().is_in_group("enemy"):
		print(ray.get_collider(), " killed")
		ray.get_collider().hp -= 1



#shake animation finish
func _on_AnimationPlayer_animation_finished(anim_name):
	weaponWait = false

#shoot animation finish
func _on_shootanimation_animation_finished(anim_name):
	weaponWait = true
