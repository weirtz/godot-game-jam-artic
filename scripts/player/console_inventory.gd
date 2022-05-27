extends GridContainer

# Script for f3 console inventory panel.

func _ready():
	GameManager.connect("player_initialised", self, "_on_player_initialised")
	
func _on_player_initialised(player):
	player.inventory.connect("inventory_changed", self, "_on_player_inventory_changed")

func _on_player_inventory_changed(inventory):
	for n in get_children():
		n.queue_free()
		
	for b in $"../../../time-pieces-container/GridContainer".get_children():
		b.queue_free()
		
	for item in inventory.get_items():
		print("Inventory updated")
		var item_label = Label.new()
		var item_label_ui = Label.new()
		item_label.text = "%s x%d" % [item.item_reference.name, item.quantity]
		item_label_ui.text = "%d/8" % [item.quantity]
		add_child(item_label)
		#If there is 8 timepieces, trigger game won.
		if item.item_reference.name == "timepiece":
			if item.quantity >= 8:
				print("Game won!")
				GameManager.game_win()
			
			$"../../../time-pieces-container/GridContainer".add_child(item_label_ui)
			if $"../../../time-pieces-container".visible == false:
				$"../../../time-pieces-container".visible = true
