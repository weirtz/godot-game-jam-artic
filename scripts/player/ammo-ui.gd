extends GridContainer

# Script for f3 console inventory panel.

func _ready():
	GameManager.connect("player_initialised", self, "_on_player_initialised")
	
func _on_player_initialised(player):
	player.inventory.connect("inventory_changed", self, "_on_player_inventory_changed")

func _on_player_inventory_changed(inventory):
	for n in get_children():
		n.queue_free()
		print("changed")
		
	for item in inventory.get_items():
		if item.item_reference.name == "weapon":
			var item_label = Label.new()
			item_label.text = "%s x%d" % ["Ammo: ", item.quantity]
			add_child(item_label)
		if item.quantity <= 0:
			#if the ammo count reaches 0 then remove weapon from hand
			var weapon = get_tree().get_root().get_node("/root/Map/KinematicBody")
			weapon.setWeaponInHand(false)
			
			
