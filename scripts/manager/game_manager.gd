extends Node

signal player_initialised

var player
var playerW
var playerWinEffect
var ball
var weaponInHand = false
var timer = 0
var wait_time = 4
var goNow = false

#checks to see if player is initialised, if not it does so and waits.
func _process(delta):
	if not player:
		initialise_player()
		return
		
func initialise_player():
	#checks if scene has a root node named 'Map' before continuing
	if get_tree().current_scene.name == "Map":
		
		#init variables
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

func game_win():
	#init vars
	var ball = get_tree().get_root().get_node("/root/Map/Ball")
	var ballCamera = get_tree().get_root().get_node("/root/Map/Ball/Camera")

	var cameraEffect = get_tree().get_root().get_node("/root/Map/Ball/Camera/win-effect")
	
	#pause ball move
	ball.setMoveToPlayer(false)
	ball.toggleCutscemePauser(false)
	
	#start timer and change ball material
	#goNow = true
	
	ball.changeBallMaterial()

	ballCamera.visible = true
	ballCamera.current = true

func init_ball():
	ball = get_tree().get_root().get_node("/root/Map/Ball")

#save inventory when changed.
func _on_player_inventory_changed(inventory):
	ResourceSaver.save("user://inventory.tres", inventory)


