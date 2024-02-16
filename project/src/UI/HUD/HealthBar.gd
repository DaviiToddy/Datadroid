extends Control

#Physics pois utiliza menos frames do que Process(delta)
func _physics_process(_delta):
	$ProgressBar.value = PlayerData.playerHP
	
