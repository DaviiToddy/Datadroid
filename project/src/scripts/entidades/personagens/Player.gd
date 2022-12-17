extends KinematicBody2D

enum PLAYER_STATES {
	DASH, WALK, RUNNING, IDLE
}
var current_state = PLAYER_STATES.IDLE

const SPEED_WALK = 400
const SPEED_RUN = 700
const MULTIPLIER_DASH = 2.5
const FRICTION = 600

var speed = SPEED_WALK
var velocity = Vector2.ZERO

func _ready() -> void:
	randomize()

func _physics_process(delta):
	move_player(delta)

func change_State(change: bool):
	
	if not change:
		return
	
	if Input.is_action_just_pressed("move_dash"):
		var last_state = current_state
		
		current_state = PLAYER_STATES.DASH
		speed = MULTIPLIER_DASH
		velocity = velocity * speed
		
		yield(get_tree().create_timer(0.8), "timeout")
		current_state = last_state
	elif Input.is_action_pressed("move_run"):
		current_state = PLAYER_STATES.RUNNING
		speed = SPEED_RUN
	else:
		current_state = PLAYER_STATES.WALK
		speed = SPEED_WALK

func move_player(delta: float):
	
	change_State(current_state != PLAYER_STATES.DASH)
	
	var input_vector: = Vector2(
		Input.get_axis("move_left", "move_right"), 
		Input.get_axis("move_forward", "move_backwards")
	)
	
	if input_vector.length() > 0.3:
		velocity.x = lerp(velocity.x, input_vector.x * speed, ease(delta, 0.5))
		velocity.y = lerp(velocity.y, input_vector.y * speed, ease(delta, 0.5))
	else:
		velocity.x = move_toward(velocity.x, input_vector.x, FRICTION * delta)
		velocity.y = move_toward(velocity.y, input_vector.y, FRICTION * delta)
	
	if velocity.length() == 0:
		current_state = PLAYER_STATES.IDLE
	
	animate()
	
	velocity = move_and_slide(velocity)

func animate():
	if velocity.x > 0:
		$Sprite.flip_h = false
	elif velocity.x < 0:
		$Sprite.flip_h = true
	
	match current_state:
		PLAYER_STATES.DASH:
			$Sprite.play("dash")
			yield($Sprite, "animation_finished")
		PLAYER_STATES.IDLE:
			$Sprite.play("idle")
		PLAYER_STATES.WALK:
			$Sprite.play("walk")
		PLAYER_STATES.RUNNING:
			$Sprite.play("run")
