extends Node2D
class_name EmoteClass

enum EMOTIONS {
	NONE, HAPPY, SAD, ANGRY
}
var current_state = EMOTIONS.NONE

func changeState():
	match current_state:
		EMOTIONS.NONE:
			hide_msg()
		EMOTIONS.HAPPY:
			$AnimatedSprite.play("happy")
			show_msg()
		EMOTIONS.SAD:
			$AnimatedSprite.play("sad")
			show_msg()
		EMOTIONS.ANGRY:
			$AnimatedSprite.play("angry")
			show_msg()

func show_msg():
	show()
	$AnimationPlayer.play("popUp")
	yield($AnimationPlayer, "animation_finished")
	
	yield(get_tree().create_timer(2.0), "timeout")
	
	$AnimationPlayer.play_backwards("popUp")
	yield($AnimationPlayer, "animation_finished")
	hide()

func hide_msg():
	if show():
		hide()
		$AnimationPlayer.play_backwards("popUp")
		show()
		yield(get_tree().create_timer(2.0), "timeout")
		hide()
	else:
		hide()
