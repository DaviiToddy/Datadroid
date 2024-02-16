class_name Bullet extends Area2D

export var max_travel_distance = 1000
var travel_target = Vector2(max_travel_distance, 0)

var damage_amount = 0
var travel_speed = 1.5

func _physics_process(delta):
	if position.x < max_travel_distance:
		position += (travel_target * travel_speed * delta).rotated(rotation)
	else:
		_despawn()

func _despawn():
	queue_free()

func move_from(from: Vector2):
	position = from

func _on_Bullet_area_entered(area):
	if area:
		PlayerData.giveEnemyDamage(
			area, #Enemy/Collider
			damage_amount #Apply this amount of damage
		)
		_despawn()

func _on_Bullet_body_entered(body):
	if body:
		PlayerData.giveEnemyDamage(
			body, #Enemy/Collider
			damage_amount #Apply this amount of damage
		)
		_despawn()
