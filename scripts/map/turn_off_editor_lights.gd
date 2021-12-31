extends Spatial

#disables editor light
func _ready():
	$EDITOR_LIGHT.visible = false

func _process(delta):
	if Input.is_action_just_pressed("test-enemy"):
		spawn_enemy()
	
#-----------------------------------
# SPAWNING ENEMIES
		
var Enemy = preload ("res://scenes/NPC/groblen.tscn")
	
func spawn_enemy():
	var ballPOS = get_tree().get_root().get_node("/root/Map/Ball/Icosphere")
	var e = Enemy.instance()
	var pos = ballPOS.global_transform.origin
	e.global_transform.origin = pos
	e.scale = Vector3(4.0, 4.0, 4.0)
	add_child(e)
