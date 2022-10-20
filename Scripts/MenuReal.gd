extends CanvasLayer

func _ready() -> void:
	$Options.hide()
	$AnimationPlayer.play("call_menu")

func _on_Button2_pressed() -> void:
	$AnimationPlayer.play_backwards("call_menu")
	yield($AnimationPlayer, "animation_finished")
	$Main.hide()
	
	$Options.show()


func _on_options_button_back_pressed() -> void:
	$Options.hide()
	$AnimationPlayer.play("call_menu")
