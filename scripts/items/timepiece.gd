# When player runs into the CollisionShape from the scene tree, it will 
# add 1 timepiece item_definition to the player inventory.

extends Area

func _on_Area_body_entered(body):
	if body == GameManager.player:
		GameManager.player.inventory.add_item("timepiece", 1)
		print(GameManager.player.inventory.get_items())
		$"../AudioStreamPlayer2D".play()
		queue_free() #remove object from scene.
