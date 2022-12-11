extends Area2D

var direction = Vector2.ZERO
export var speed = 5
export var max_distance = 500
var owner_ = null 

func setup(owner, position, direction):
	global_position = position
	self.direction = direction 
	owner_ = owner

func _ready():
	pass

func _process(delta):
	var velocity = direction * speed
	position += velocity
	if owner_:
		if (owner_.position - position).length() > max_distance:
			queue_free()
