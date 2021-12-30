# When player runs into the CollisionShape from the scene tree, it will 
# add 1 timepiece item_definition to the player inventory.

extends Area

export var time = 10

func _on_Area_body_entered(body):
	if body == GameManager.player:
		GameManager.player.inventory.add_item("timepiece", 1)
		GameManager.ball.move_ball_back_secs(time)
		print(GameManager.player.inventory.get_items())
		$"../AudioStreamPlayer2D".play()
		$"../AnimationPlayer".queue_free()
		queue_free() #remove object from scene.
