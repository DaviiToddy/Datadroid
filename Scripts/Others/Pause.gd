extends Control

var PausadoOuNao = -1


func _ready():
	hide()
	



func _unhandled_input(event):
	
	if Input.is_action_just_pressed("ui_esq"):
		PausadoOuNao *= -1
		print()
		
		
		if PausadoOuNao == 1:
			print()
			show()
			get_tree().paused = true
			
			
			
	if PausadoOuNao == -1:
		print()
		hide()
		get_tree().paused = false

export(String, FILE, "*.tscn") var world_scene;


func _on_Button_pressed():
	get_tree().paused = false
	hide()
	get_tree().change_scene(world_scene)
	pass # Replace with function body.





func _on_Button2_pressed():
	get_tree().paused = false
	hide()
	$"Transição2/ColorRect/AnimationPlayer".play("Exit")
	get_tree().quit()
	pass # Replace with function body.
