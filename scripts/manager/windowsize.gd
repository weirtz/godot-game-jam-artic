extends Node

func _ready():
	#set game window
	OS.window_size = Vector2(1280,720)
	var screen_size = OS.get_screen_size()
	var window_size = OS.get_window_size()
	OS.set_window_position(screen_size*0.5 - window_size*0.5)