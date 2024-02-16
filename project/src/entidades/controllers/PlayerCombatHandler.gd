#
# Responsavel por Combates Melee, Tiros e todo
# o resto do sistema de Combate.
# 
# Incluso estados, sinais, funções e variaveis
# para uso "global" do sistema
#
class_name CombatHandler extends Node2D

const AIM_MELEE_ZOOM_CAM = 2
const AIM_SIGHT_ZOOM_CAM = 5

var bullet_scene = preload("res://content/scenes/prefabs/misc/Bullet.tscn")

export(Enums.Combats) var current_combat
export(Enums.CombatStates) var currentCombatState

onready var meleeHandler = MeleeCombat.new()
onready var firearmHandler = FireArmCombat.new()
var meleeCollisionBody

func _physics_process(delta):
	$GunCrosshair.position = get_local_mouse_position()
	
	if current_combat == Enums.Combats.FIREARM:
		$GunCrosshair.modulate.a = move_toward(
			$GunCrosshair.modulate.a, 1.0, 4 * delta) #max alpha
	else:
		$GunCrosshair.modulate.a = move_toward(
			$GunCrosshair.modulate.a, 0.0, 2 * delta) #min alpha

func attack():
	#Is it a melee attack?
	if current_combat == Enums.Combats.MELEE:
		meleeAttack()
	elif current_combat == Enums.Combats.FIREARM:
		fireArmAttack()

func meleeAttack():
	if not $MeleeTimer.time_left and meleeCollisionBody:
		currentCombatState = Enums.CombatStates.ATTACKING
		meleeHandler._attack() #Adapts damage based on type
		PlayerData.giveEnemyDamage(
			meleeCollisionBody.get_parent(), #Enemy/Collider
			meleeHandler.damage_amount #Apply this amount of damage
		)
		$MeleeTimer.start() #Countdown to next attack

func fireArmAttack():
	if not $FireTimer.time_left:
		currentCombatState = Enums.CombatStates.ATTACKING
		firearmHandler._attack() #Adapts damage based on type
		var bullet = bullet_scene.instance()
		bullet.damage_amount = firearmHandler.damage_amount
		bullet.rotation = get_local_mouse_position().angle()
		$Bullets.add_child(bullet)
		$FireTimer.start() #Countdown to next attack

#Callback Functions
func _on_MeleeTimer_timeout():
	currentCombatState = Enums.CombatStates.PEACE
func _on_FireTimer_timeout():
	currentCombatState = Enums.CombatStates.PEACE

func _on_MeleeCombatHandler_area_entered(area):
	if area:
		meleeCollisionBody = area
func _on_MeleeCombatHandler_area_exited(area):
	if area:
		meleeCollisionBody = null
