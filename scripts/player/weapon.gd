extends Spatial

onready var anim = $"bottleblaster/shoot-animation"
onready var animReload = $"bottleblaster/AnimationPlayer"
onready var ray = $"../RayCastWeapon"

func _input(event):
	if Input.is_action_just_pressed("shoot"):
		anim.play("shoot")
		animReload.play("shake")

func fire():
	if ray.get_collider() != null and ray.get_collider().is_in_group("enemy"):
		print(ray.get_collider())
		#ray.get_collider.hp -= 10
