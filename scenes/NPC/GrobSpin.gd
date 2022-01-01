extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var player_body
var playerLoc = Vector3()
var turning = true

# Called when the node enters the scene tree for the first time.
func _ready():
	player_body = get_tree().get_root().get_node("Map/KinematicBody")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (turning):
		look_at(player_body.translation, Vector3.UP)
	
func _enable_turn():
	turning = true
	
func _disable_turn():
	turning = false
