extends Control

func _on_transition_animation_finished(anim_name):
	get_tree().change_scene("res://scenes/maps/city.tscn")

func _on_Play_pressed():
	var dir = Directory.new()
	if dir != null:
		dir.remove("user://inventory.tres")
		$Control.visible = true
		$"Control/transition".play("trans")
		

