extends Control

#Physics pois utiliza menos frames do que Process(delta)
func _physics_process(delta):
	$ProgressBar.value = PlayerData.playerHP
	
