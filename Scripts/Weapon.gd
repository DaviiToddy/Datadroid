extends Node2D

export var rpm = 50
export(PackedScene) var bullet_scene = null

var delay = 0

func _ready():
	pass
	
func _process(delta):
	delay += delta
	
func shoot(owner, position, direction):
	if delay < 60/rpm:
		return
		
	var bullet = bullet_scene.instance()
	bullet.setup(owner, position, direction)
	owner.get_parent().add_child(bullet)
	delay = 0
	
