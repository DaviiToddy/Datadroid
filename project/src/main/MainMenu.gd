extends Control

export(PackedScene) onready var main_scene
onready var start_button = $Buttons/Start

func _ready() -> void:
	$AnimationPlayer.play("popup_menu")
	start_button.grab_focus()
	.show()

func _on_play_button_pressed() -> void:
	if main_scene:
		$AnimationPlayer.play_backwards("popup_menu")
		yield($AnimationPlayer, "animation_finished")
		return get_tree().change_scene_to(main_scene)

func _on_quit_button_pressed() -> void:
	get_tree().quit()
