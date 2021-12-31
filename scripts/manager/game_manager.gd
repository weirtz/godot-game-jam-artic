extends Node

signal player_initialised

var player
var playerW
var ball
var weaponInHand = false

#checks to see if player is initialised, if not it does so and waits.
func _process(delta):
	if not player:
		initialise_player()
		return
func initialise_player():
	#checks if scene has a root node named 'Map' before continuing
	if get_tree().current_scene.name == "Map":
		player = get_tree().get_root().get_node("/root/Map/KinematicBody")
		if not player:
			return
		
		emit_signal("player_initialised", player)
		player.inventory.connect("inventory_changed", self, "_on_player_inventory_changed")
		var dir = Directory.new()
		#load existing inventory.
		if dir != null:
			#var existing_inventory = load("user://inventory.tres")
			#if existing_inventory:
			#	player.inventory.set_items(existing_inventory.get_items())
			#Give starting items. This will run if it is a new game.
			pass
		else:
			#player.inventory.add_item("testItem", 3)
			pass


func init_ball():
	ball = get_tree().get_root().get_node("/root/Map/Ball")

#save inventory when changed.
func _on_player_inventory_changed(inventory):
	ResourceSaver.save("user://inventory.tres", inventory)
