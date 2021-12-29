extends Area

func _on_StaminaItem_body_entered(body):
	if body == GameManager.player:
		GameManager.player.inventory.add_item("stamina", 1)
		print(GameManager.player.inventory.get_items())
		#$"../AudioStreamPlayer2D".play()
		queue_free() #remove object from scene.
