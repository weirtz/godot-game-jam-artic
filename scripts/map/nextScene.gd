extends AnimationPlayer
onready var scienceDone = $"../../"

#screen transition
func _on_AnimationPlayerScreentransition_animation_finished(_anim_name):
	if scienceDone.scienceScene == true:
		self.play("begining-cutscene")
		get_tree().get_root().get_node("/root/Map/science").visible = true
		$"../Camera1/screen_text/AnimationPlayer".play("typewriter")
		$"../Camera1/screen_text".visible = true
#scene1
func _on_AnimationPlayer_animation_finished(_anim_name):
	if scienceDone.scienceScene == true:
		$"../Camera2/screen_text/AnimationPlayer2-1".play("typewriter")
		$"../Camera1/screen_text".visible = false
		$"../Camera2/screen_text".visible = true

func _on_AnimationPlayer21_animation_finished(_anim_name):
	if scienceDone.scienceScene == true:
		$"../Camera2/screen_text/AnimationPlayer2-2".play("typewriter")
	
func _on_AnimationPlayer22_animation_finished(_anim_name):
	if scienceDone.scienceScene == true:
		$"../Camera3/screen_text/AnimationPlayer3-1".play("typewriter")
		$"../Camera2/screen_text".visible = false
		$"../Camera3/screen_text".visible = true

func _on_AnimationPlayer31_animation_finished(_anim_name):
	if scienceDone.scienceScene == true:
		$"../Camera3/screen_text/AnimationPlayer3-2".play("typewriter")
	
func _on_AnimationPlayer32_animation_finished(_anim_name):
	if scienceDone.scienceScene == true:
		$"../Camera4/screen_text/AnimationPlayer4-1".play("typewriter")
		$"../Camera3/screen_text".visible = false
		$"../Camera4/screen_text".visible = true

func _on_AnimationPlayer41_animation_finished(_anim_name):
	if scienceDone.scienceScene == true:
		$"../Camera5/screen_text/AnimationPlayer5-1".play("typewriter")
		$"../Camera4/screen_text".visible = false
		$"../Camera5/screen_text".visible = true


func _on_AnimationPlayer51_animation_finished(_anim_name):
	if scienceDone.scienceScene == true:
		$"../Camera6/screen_text/AnimationPlayer6-1".play("typewriter")
		$"../Camera5/screen_text".visible = false
		$"../Camera6/screen_text".visible = true


func _on_AnimationPlayer61_animation_finished(_anim_name):
	if scienceDone.scienceScene == true:
		$"../Camera6/screen_text".visible = false




