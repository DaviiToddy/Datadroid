extends Control

func _on_HSlider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), value)

func _on_HSlider2_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), value)

func _on_HSlider3_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), value)

#CallbackFunctions
func _on_CheckBox_toggled(button_pressed: bool) -> void:
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), button_pressed)

func _on_CheckBox2_toggled(button_pressed: bool) -> void:
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Music"), button_pressed)

func _on_CheckBox3_toggled(button_pressed: bool) -> void:
	AudioServer.set_bus_mute(AudioServer.get_bus_index("SFX"), button_pressed)
