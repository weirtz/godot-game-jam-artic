extends Control

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _on_transition_animation_finished(_anim_name):
	get_tree().change_scene("res://scenes/maps/city.tscn")

func _on_Play_pressed():
	var dir = Directory.new()
	#reload ItemDatabase, this prevents crash on second play after completing game the first time without relaunching program
	ItemDatabase.inventoryInit()
	if dir != null:
		dir.remove("user://inventory.tres")
		$Control.visible = true
		$"Control/transition".play("trans")

func _on_Button_pressed():
	get_tree().quit()
