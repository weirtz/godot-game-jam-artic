extends Spatial

onready var anim = $"bottleblaster/shoot-animation"
onready var animReload = $"bottleblaster/AnimationPlayer"
onready var ray = $"../RayCastWeapon"
var weaponWait = false

func _input(event):
	if Input.is_action_just_pressed("shoot") and weaponWait == false:
		check_for_ammo("weapon")
		
#checks to see if the player has any ammo, if so, shoot
func check_for_ammo(item_name):
	for i in range(GameManager.player.inventory.get_items().size()):
		var item = ItemDatabase.getItem(item_name)
		var inventory_item = GameManager.player.inventory.get_item(i)
		if inventory_item.item_reference.name != item.name:
			continue
		if inventory_item.quantity <= 0:
			continue
		if inventory_item.quantity > 0:
			weaponWait = true
			anim.play("shoot")
			animReload.play("shake")
			print("shot")
			fire()

#removes 1 ammo from player and checks to see if it hits an enemy.
func fire():
	GameManager.player.inventory.remove_item("weapon", 1)
	if ray.get_collider() != null and ray.get_collider().is_in_group("enemy"):
		print(ray.get_collider(), " killed")
		ray.get_collider().hp -= 1

#shake animation finish
func _on_AnimationPlayer_animation_finished(anim_name):
	weaponWait = false

#shoot animation finish
func _on_shootanimation_animation_finished(anim_name):
	weaponWait = true
