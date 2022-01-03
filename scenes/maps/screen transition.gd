extends Control

#get window size for screen transition
var windowX
var windowY

# Called when the node enters the scene tree for the first time.
func _ready():
	windowX = OS.get_real_window_size().x
	windowY = OS.get_real_window_size().y

	self.material.set_shader_param("screen_width",windowX)
	self.material.set_shader_param("screen_height",windowY)
