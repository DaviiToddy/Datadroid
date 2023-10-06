class_name Player extends KinematicBody2D

const FRICTION = 600.0
const SPEED_WALK = 400.0
const SPEED_RUN = 700.0
const DASH_MULTIPLIER = 3.0
const INPUT_DEADZONE = 0.3

var speed: = SPEED_WALK
var velocity: = Vector2.ZERO
var velocity_dash: = Vector2.ZERO

onready var animationTree = $AnimationTree
onready var stateMachine = animationTree.get("parameters/playback")

func _ready() -> void:
	animationTree.set("parameters/conditions/is_dash_timeout", true)

func _physics_process(delta) -> void:
	actions_handler()
	move_player(delta)

func actions_handler() -> void:
	_flip_sprite()
	if not animationTree.get("parameters/conditions/is_dash_timeout"):
		return
	if Input.is_action_just_pressed("move_dash"):
		_animate("dash")
		animationTree.set("parameters/conditions/is_dash_timeout", false)
		speed = DASH_MULTIPLIER
		velocity = velocity * speed
		$DashTimer.start()
		return
	if Input.is_action_pressed("move_run"):
		_animate("run")
		speed = SPEED_RUN
	elif velocity.length() <= INPUT_DEADZONE:
		_animate("idle")
	else:
		_animate("walk")
		speed = SPEED_WALK

func move_player(delta: float) -> void:
	var input_vector: = Vector2(
		Input.get_axis("move_left", "move_right"),
		Input.get_axis("move_forward", "move_backwards")
	).normalized()
	
	if input_vector.length() >= INPUT_DEADZONE:
		velocity.x = lerp(velocity.x, input_vector.x * speed, ease(delta, 0.5))
		velocity.y = lerp(velocity.y, input_vector.y * speed, ease(delta, 0.5))
	elif input_vector.length() <= INPUT_DEADZONE:
		velocity.x = move_toward(velocity.x, input_vector.x, FRICTION * delta)
		velocity.y = move_toward(velocity.y, input_vector.y, FRICTION * delta)
	velocity = move_and_slide(velocity)

func _animate(animation: String):
	if not animation as String:
		return
	if not $AnimationPlayer.play(animation):
		return
	stateMachine.travel(animation)

func _flip_sprite():
	if velocity.x > 0: #Flip sprites RIGHT
		$Sprite.flip_h = false
	if velocity.x < 0: #Flip sprites LEFT
		$Sprite.flip_h = true

func _on_DashTimer_timeout() -> void:
	animationTree.set("parameters/conditions/is_dash_timeout", true)
