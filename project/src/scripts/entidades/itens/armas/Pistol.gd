class_name Pistol extends GunAbstract

export(NodePath) var gunSprite
export(NodePath) var gunFlameSprite
export(NodePath) var gunTimerShoot
export(NodePath) var gunSoundStream

func _ready() -> void:
	gunSprite = .get_node(gunSprite) as AnimatedSprite
	gunFlameSprite = .get_node(gunFlameSprite) as AnimatedSprite
	gunTimerShoot = .get_node(gunTimerShoot) as Timer
	gunSoundStream = .get_node(gunSoundStream) as AudioStreamPlayer2D

func shoot():
	if ._is_possible_to_shoot() and !gunTimerShoot.time_left:
		.shoot()
		gunFlameSprite.frame = 0
		gunFlameSprite.show()
		
		gunTimerShoot.start()
		gunSoundStream.play()
		gunSprite.play("shoot")
		gunFlameSprite.play("fire")
		
		yield(gunTimerShoot, "timeout")
		gunFlameSprite.hide()
		gunSprite.play("idle")
		gunFlameSprite.frame = 0

func reload():
	.reload()
