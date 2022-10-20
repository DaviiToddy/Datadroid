extends Control

export(PackedScene) onready var game_level

func _on_Start_pressed():
	$"../AnimationPlayer".play("fadeOutMenu")
	yield($"../AnimationPlayer", "animation_finished")
	$AudioStreamPlayer.stop()
	Ui.game(true)
	get_tree().change_scene_to(game_level)

func _on_Options_pressed():
	pass # Replace with function body.

func _on_Quit_pressed():
	get_tree().quit()
