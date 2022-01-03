extends Spatial

func _ready():
	$Camera1.current = true

func cameraSelect(var cameraNum):
	match cameraNum:
		1:
			$Camera1.current = true
		2: 
			$Camera2.current = true
		3:
			$Camera3.current = true
		4: 
			$Camera4.current = true
		5:
			$Camera5.current = true
		6: 
			$Camera6.current = true
		7:
			var playerCam = get_tree().get_root().get_node("/root/Map/KinematicBody/PlayerCamera")
			playerCam.current = true
			
			#hide scientist
			
			var playerUIstamina = get_tree().get_root().get_node("/root/Map/KinematicBody/GUI/Stamina")
			var playerUIcrosshair = get_tree().get_root().get_node("/root/Map/KinematicBody/GUI/crosshair")
			var playerUIball = get_tree().get_root().get_node("/root/Map/Ball/Control")
			var playerUIScience = get_tree().get_root().get_node("/root/Map/science")
			playerUIstamina.visible = true
			playerUIcrosshair.visible = true
			playerUIball.visible = true
			playerUIScience.visible = false
			
