extends Node

class State:
	var is_transient = false
	
	func _init():
		pass

	func on_anim_event(owner, event):
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
		

var stack = []
var enum_to_state = {}
var state_to_enum = {}

func _ready():
	pass

func on_anim_event(owner, event):
	front().on_anim_event(owner, event)
	return
	
func update(owner, dt, space=null):
	var idx = 0
	while idx < stack.size():
		var state = stack[idx]
		idx+=1
		if space != null:
			state.execute_physics(owner, self, dt, space)
		else:
			state.execute(owner, self, dt)
		if state != null and not state.is_transient:
			break
		continue

func front():
	return stack.front()
	
func get_state(id):
	return enum_to_state[id]
	
func running_state():
	if front() == null:
		return -1
	return state_to_enum[front()]
	
func register_state(id, state):
	enum_to_state[id] = state
	state_to_enum[state] = id
	
func push_state(owner, state, pop_prev = false):
	if pop_prev:
		pop_state(owner)
	stack.push_front(state)
	state.on_enter(owner)
	#print("pushing state " + str(state))
	return state
	
func pop_state(owner):
	var state = stack.pop_front()
	if state:
		state.on_exit(owner)
	#print("Poping state " + str(state))
	return state
