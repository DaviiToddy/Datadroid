extends Control

export(PackedScene) onready var world_scene;

func _on_Button_pressed():
	get_tree().change_scene_to(world_scene)

func _on_Button3_pressed():
	get_tree().quit()
