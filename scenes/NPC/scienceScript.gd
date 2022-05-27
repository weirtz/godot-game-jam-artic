extends Spatial

onready var animPlayer = get_node("ScienceAnimationPlayer")
onready var sprite = get_node("ScienceSprite")
onready var view = get_node("ScienceViewport")
onready var cam = get_node("ScienceViewport/ScienceCamera")
	
func _enableSprite():
	sprite.show()

func _disableSprite():
	sprite.hide()

func _setAnimation(var animNum):
	match animNum:
		0:
			animPlayer.play("TalkTemplate")
		1: 
			animPlayer.play("TalkIntroduce")
		2: 
			animPlayer.play("TalkExplain")
		3: 
			animPlayer.play("TalkPoint")
		4: 
			animPlayer.play("TalkBrain")
		5: 
			animPlayer.play("TalkFlex")
		6: 
			animPlayer.play("TalkScratch")
		7: 
			animPlayer.play("TalkGoodRiddance")

