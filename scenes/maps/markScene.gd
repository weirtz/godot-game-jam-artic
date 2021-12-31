extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var scientist = get_node("science")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (Input.is_key_pressed(16777347)):
		scientist._disableSprite()
		
	if (Input.is_key_pressed(16777349)):
		scientist._enableSprite()
		
	if (Input.is_key_pressed(16777350)):
		scientist._setAnimation(0)
		
	if (Input.is_key_pressed(16777351)):
		scientist._setAnimation(1)
		
	if (Input.is_key_pressed(16777352)):
		scientist._setAnimation(2)
		
	if (Input.is_key_pressed(16777353)):
		scientist._setAnimation(3)
		
	if (Input.is_key_pressed(16777354)):
		scientist._setAnimation(4)
		
	if (Input.is_key_pressed(16777355)):
		scientist._setAnimation(5)
		
	if (Input.is_key_pressed(16777356)):
		scientist._setAnimation(6)
		
	if (Input.is_key_pressed(16777357)):
		scientist._setAnimation(7)
