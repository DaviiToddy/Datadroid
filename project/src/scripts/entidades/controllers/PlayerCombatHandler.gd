#
# Responsavel por Combates Melee, Tiros e todo
# o resto do sistema de Combate.
# 
# Incluso estados, sinais, funções e variaveis
# para uso "global" do sistema
#
class_name CombatHandler extends Node2D

export(Enums.Combats) var current_combat
export(Enums.CombatStates) var currentCombatState

onready var meleeHandler = MeleeCombat.new()
var meleeCollisionBody

func attack():
	#Is it a melee attack?
	if current_combat == Enums.Combats.MELEE:
		meleeAttack()
	
	currentCombatState = Enums.CombatStates.ATTACKING

func meleeAttack():
	if not $MeleeTimer.time_left and meleeCollisionBody:
		meleeHandler._attack() #Adapts damage based on type
		PlayerData.giveEnemyDamage(
			meleeCollisionBody.get_parent(), #Enemy/Collider
			meleeHandler.damage_amount #Apply this amount of damage
		)
		$MeleeTimer.start() #Countdown to next attack


#Callback Functions
func _on_MeleeCombatHandler_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	if area:
		meleeCollisionBody = area
func _on_MeleeCombatHandler_area_shape_exited(area_rid, area, area_shape_index, local_shape_index):
	if area:
		meleeCollisionBody = null
