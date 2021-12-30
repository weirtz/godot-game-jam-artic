extends MarginContainer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# resume game button
func _on_MenuButton_pressed():
	get_tree().change_scene("res://scenes/maps/ball_test_playground.tscn")

# new game button
func _on_New_Game_pressed():
	var dir = Directory.new()
	if dir != null:
		dir.remove("user://inventory.tres")
		get_tree().change_scene("res://scenes/maps/ball_test_playground.tscn")
