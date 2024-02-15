class_name Player extends KinematicBody2D

const FRICTION = 800.0
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
	actions_handler(delta)
	combat_handler(delta)
	move_player(delta)
	$CombatHandler/MeleeCombatHandler.position = velocity * 0.5

func actions_handler(delta: float) -> void:
	_flip_sprite()
	if not animationTree.get("parameters/conditions/is_dash_timeout"):
		return
	if Input.is_action_just_pressed("move_dash"):
		_animate("dash")
		animationTree.set("parameters/conditions/is_dash_timeout", false)
		#DASH
		#speed = DASH_MULTIPLIER
		#velocity = velocity * speed
		velocity = velocity * (1.5 + (1 / DASH_MULTIPLIER)) #Idk
		#speed = (velocity.length() / 4) * (SPEED_WALK / DASH_MULTIPLIER / 3)
		$DashTimer.start()
		return
	
	if velocity.length() >= INPUT_DEADZONE:
		if Input.is_action_pressed("move_run"):
			_animate("run")
			speed = SPEED_RUN
		else:
			_animate("walk")
			speed = SPEED_WALK
	else:
		_animate("idle")

func combat_handler(delta: float):
	#HUD
	if $CombatHandler.current_combat == Enums.Combats.FIREARM:
		$HUD/AttackCountBar.modulate.a = move_toward(
			$HUD/AttackCountBar.modulate.a, 0.0, 2 * delta) #max alpha
	else:
		$HUD/AttackCountBar.modulate.a = move_toward(
			$HUD/AttackCountBar.modulate.a, 1.0, 4 * delta) #min alpha
	
	
	if Input.is_action_pressed("gun_shoot"):
		$CombatHandler.attack()
	if Input.is_action_just_pressed("gun_change"):
		if $CombatHandler.current_combat == Enums.Combats.FIREARM:
			$CombatHandler.current_combat = Enums.Combats.MELEE
		else:
			$CombatHandler.current_combat = Enums.Combats.FIREARM
	
	if not $CombatHandler.currentCombatState == \
	Enums.CombatStates.ATTACKING:
		#Meaning that no attack was effected
		return
	
	if $CombatHandler.current_combat == Enums.Combats.MELEE:
		if $CombatHandler.meleeHandler.attackType == MeleeCombat.attacks.PUNCH:
			 _animate("punch")
		elif $CombatHandler.meleeHandler.attackType == MeleeCombat.attacks.KICK:
			 _animate("kick")
		$HUD/AttackCountBar.value = $CombatHandler.meleeHandler.meleeAttackCount

func move_player(delta: float) -> void:
	var input_vector: = Vector2(
		Input.get_axis("move_left", "move_right"),
		Input.get_axis("move_forward", "move_backwards")
	).normalized()
	
	if input_vector.length() >= INPUT_DEADZONE:
		velocity.x = lerp(velocity.x, input_vector.x * speed, ease(delta, 0.25))
		velocity.y = lerp(velocity.y, input_vector.y * speed, ease(delta, 0.25))
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
	velocity.x = move_toward(velocity.x, 0, velocity.length() / 2)
	velocity.y = move_toward(velocity.y, 0, velocity.length() / 2)
