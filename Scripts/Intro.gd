extends Timer


export(String, FILE, "*.tscn") var world_scene;

func _on_Timer_timeout():
	get_tree().change_scene(world_scene)
