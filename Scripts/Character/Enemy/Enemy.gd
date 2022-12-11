extends KinematicBody2D

var FSM = preload("res://Scripts/Others/FSM.gd")

enum State_t {
	IDLE,
	WANDERING,
	ATTACKING
}


class State:
	var is_transient = false
	
	func _init():
		pass

	func on_enter(owner):
		pass
		
	func on_exit(owner):
		pass
	
	func execute(owner, machine, dt):
		pass
		
	func execute_physics(owner, machine, dt, space = null):
		pass
		
	func get_type():
		return 0
		
		
class WanderState extends State:
	var wander_offset = 20
	var wander_point = Vector2.ZERO
	var wander_dir = Vector2.ZERO
	var max_dist = 500
	
	func _init():
		wander_dir = Vector2(randf(), randf())
		
	func execute_physics(owner, machine, dt, space = null):
		if randi() % 20 == 10:
			wander_dir += Vector2(rand_range(-1,1), 0)
		if randi() % 20 == 10:
			wander_dir += Vector2(0, rand_range(-1,1))
		if owner.position.distance_squared_to(owner.original_pos) > max_dist * max_dist:
			wander_dir = owner.original_pos - owner.position
			
		var wander_point = owner.position + owner.facing_dir * wander_offset
		wander_dir = wander_dir.normalized()
		wander_point = wander_point + wander_dir
		var velocity = (wander_point - owner.position).normalized() * owner.MAX_SPEED 
		owner.velocity = velocity
		
	func get_type():
		return State_t.WANDERING
	
class AttackState extends State:
	var input = Vector2.ZERO
	var timer = 0
	
	func _init():
		pass
		
	func execute_physics(owner, machine, dt, space = null):
		if not owner.oponent:
			owner.fsm.pop_state(owner)
			return
			
		timer += dt
		input = Vector2.ZERO
		if owner.position.distance_squared_to(owner.oponent.position) > owner.ATTACK_DISTANCE  * owner.ATTACK_DISTANCE:
			input = (owner.oponent.position - owner.position).normalized() + Vector2(sin(timer) * 0.5, sin(timer) * 0.5).rotated(-owner.velocity.angle())
		#else:
		#	input = Vector2(sin(timer), sin(timer)).rotated(((owner.oponent.position - owner.position)).angle())
		owner.velocity = owner.velocity.linear_interpolate(input * owner.MAX_SPEED, dt)
		
		if int(timer) % 1 == 0:
			owner.get_node("Weapon").shoot(owner, owner.position, (owner.oponent.position - owner.position).normalized())
	
	func get_type():
		return State_t.ATTACKING
		
export var MAX_HEALTH = 100
export var MAX_SPEED = 200

export var SEE_DISTANCE = 400
export var ATTACK_DISTANCE = 300

export(NodePath) var enemy_path

var velocity = Vector2.ZERO
var facing_dir = Vector2(1, 0)
var oponent = null

onready var original_pos = position
onready var sprite = $AnimatedSprite

onready var fsm = FSM.new()

func _ready():

	fsm.push_state(self, WanderState.new())
	
	oponent = get_node(enemy_path)
	
	set_physics_process(true)
	
func _process(delta):
	
	sprite.flip_h = true
	if facing_dir.x > 0.1:
		sprite.flip_h = false
	
	fsm.update(self, delta)
	
func _physics_process(delta):
	var space = get_world_2d().direct_space_state
	
	var objects = get_nearby_objects(space, self, position, SEE_DISTANCE)
	for object in objects:
		if object["collider"] == self:
			continue
		if object["collider"] == oponent and fsm.front().get_type() != State_t.ATTACKING:
			fsm.push_state(self, AttackState.new())
	
	fsm.update(self, delta, space)
	
	move_and_slide(velocity)
	if abs(velocity.length_squared()) > 0:
		facing_dir = velocity.normalized()
	
func get_nearby_objects(space, owner, pos, radius):
	var shape = CircleShape2D.new()
	shape.set_radius(radius)
	var query = Physics2DShapeQueryParameters.new()
	var transform = Transform2D()
	transform.origin = pos
	query.exclude = [owner]
	query.transform = transform
	query.set_shape(shape)
	var objects = space.intersect_shape(query, 10)
	return objects
