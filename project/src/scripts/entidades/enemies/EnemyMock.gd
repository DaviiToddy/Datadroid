class_name EnemyMock extends Node2D

const MAX_HP = 100
var HP = MAX_HP

func _physics_process(delta):
	$ProgressBar.value = HP

func takeDamage(damage_amount: float) -> void:
	if HP - damage_amount <= 0:
		queue_free()
	HP -= damage_amount
	$DamageTimer.start()
	$ProgressBar.show()
	yield($DamageTimer, "timeout")
	$ProgressBar.hide()
