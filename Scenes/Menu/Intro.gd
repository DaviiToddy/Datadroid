extends CanvasLayer

export(PackedScene) onready var main_menu

func _ready() -> void:
	$Label.hide()
	$Label2.hide()
	
	$AnimationPlayer.play("intro")
	yield($AnimationPlayer, "animation_finished")
	$AnimationPlayer.play_backwards("intro")
	yield($AnimationPlayer, "animation_finished")
	
	$AnimationPlayer.play("logo")
	yield($AnimationPlayer, "animation_finished")
	yield(get_tree().create_timer(2.0), "timeout")
	$AnimationPlayer.play_backwards("logo")
	yield($AnimationPlayer, "animation_finished")
	
	$"Transição/AnimationPlayer".play_backwards("fade_out")
	yield($"Transição/AnimationPlayer", "animation_finished")
	get_tree().change_scene_to(main_menu)
