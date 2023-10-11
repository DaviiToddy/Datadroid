class_name EnemyMock extends Node2D

const MAX_HP = 100
export var HP = MAX_HP

func _ready():
	$ProgressBar.max_value = HP

func _physics_process(delta):
	$ProgressBar.value = HP

func takeDamage(damage_amount: float) -> void:
	if HP - damage_amount <= 0:
		queue_free()
	HP -= damage_amount
	$HpShowTimer.start()
	$ProgressBar.show()
	yield($HpShowTimer, "timeout")
	$ProgressBar.hide()

func _on_CombatCollider_area_entered(area):
	var is_it_bullets = area as Bullet
	if is_it_bullets:
		takeDamage(is_it_bullets.damage_amount)
