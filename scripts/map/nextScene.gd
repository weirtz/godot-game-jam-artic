extends AnimationPlayer


#scene1
func _on_AnimationPlayer_animation_finished(anim_name):
	$"../Camera2/screen_text/AnimationPlayer2-1".play("typewriter")
	$"../Camera1/screen_text".visible = false
	$"../Camera2/screen_text".visible = true

func _on_AnimationPlayer21_animation_finished(anim_name):
	$"../Camera2/screen_text/AnimationPlayer2-2".play("typewriter")
	
func _on_AnimationPlayer22_animation_finished(anim_name):
	$"../Camera3/screen_text/AnimationPlayer3-1".play("typewriter")
	$"../Camera2/screen_text".visible = false
	$"../Camera3/screen_text".visible = true

func _on_AnimationPlayer31_animation_finished(anim_name):
	$"../Camera3/screen_text/AnimationPlayer3-2".play("typewriter")
	
func _on_AnimationPlayer32_animation_finished(anim_name):
	$"../Camera4/screen_text/AnimationPlayer4-1".play("typewriter")
	$"../Camera3/screen_text".visible = false
	$"../Camera4/screen_text".visible = true

func _on_AnimationPlayer41_animation_finished(anim_name):
	$"../Camera5/screen_text/AnimationPlayer5-1".play("typewriter")
	$"../Camera4/screen_text".visible = false
	$"../Camera5/screen_text".visible = true


func _on_AnimationPlayer51_animation_finished(anim_name):
	$"../Camera6/screen_text/AnimationPlayer6-1".play("typewriter")
	$"../Camera5/screen_text".visible = false
	$"../Camera6/screen_text".visible = true


func _on_AnimationPlayer61_animation_finished(anim_name):
	$"../Camera6/screen_text".visible = false


