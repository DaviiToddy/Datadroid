extends KinematicBody2D

export(NodePath) onready var player = get_node(player)

enum ROBOT_STATES {
	WALK, RUNNING, IDLE
}
var current_state = ROBOT_STATES.IDLE

const SPEED_WALK = 400
const SPEED_RUN = 700
const SPEED_IDLE = 0
const FRICTION = 300

var speed: = SPEED_WALK
var velocity: = Vector2.ZERO
var input_vector: = Vector2.ZERO
var is_safe: = false

func _ready() -> void:
	randomize()

func _physics_process(delta):
	move_player(delta)
	velocity = move_and_slide(velocity)

func move_player(delta: float):
	
	var distance_player: Vector2 = player.global_position - global_position
	
	if distance_player.length() > 300 and not is_safe:
		current_state = ROBOT_STATES.RUNNING
		speed = SPEED_RUN
	elif distance_player.length() > 200 and not is_safe:
		current_state = ROBOT_STATES.WALK
		speed = SPEED_WALK
	else:
		speed = SPEED_IDLE
		distance_player = Vector2.ZERO
	
	input_vector = Vector2.ZERO.direction_to(distance_player) * 0.5
	
	if input_vector.length() > 0.3:
		velocity.x = lerp(velocity.x, input_vector.x * speed, ease(delta, 0.5))
		velocity.y = lerp(velocity.y, input_vector.y * speed, ease(delta, 0.5))
	else:
		velocity.x = move_toward(velocity.x, input_vector.x, FRICTION * delta)
		velocity.y = move_toward(velocity.y, input_vector.y, FRICTION * delta)
	
	if velocity.length() == 0:
		current_state = ROBOT_STATES.IDLE
	
	animate()

func animate():
	
	if velocity.x > 0:
		$Sprite.flip_h = false
	elif velocity.x < 0:
		$Sprite.flip_h = true
	
	match current_state:
		ROBOT_STATES.IDLE:
			$Sprite.play("idle")
		ROBOT_STATES.WALK:
			$Sprite.play("walk")
		ROBOT_STATES.RUNNING:
			$Sprite.play("run")


#Callback functions
func _on_PlayerRange_body_entered(body: Node) -> void:
	if body.name == "Player":
		is_safe = true

func _on_PlayerRange_body_exited(body: Node) -> void:
	if body.name == "Player":
		is_safe = false
