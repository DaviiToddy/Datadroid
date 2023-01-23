extends Control

func _ready() -> void:
	$AnimationPlayer.play_backwards("popup_menu")

func show():
	$AnimationPlayer.play("popup_menu")
	$VBoxContainer/Button.grab_focus()
	.show()

func _on_play_button_pressed() -> void:
	$AnimationPlayer.play_backwards("popup_menu")
	get_parent()._play_triggered()

func _on_quit_button_pressed() -> void:
	$ConfirmationDialog.show()

func _on_armory_button_pressed() -> void:
	$AnimationPlayer.play_backwards("popup_menu")
	get_parent()._changeScreen("armory")
