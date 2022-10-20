extends Button



export(String, FILE, "*.tscn") var world_scene;

func _on_Button2_pressed():
	get_tree().paused = false
	get_tree().change_scene(world_scene)
	pass # Replace with function body.
