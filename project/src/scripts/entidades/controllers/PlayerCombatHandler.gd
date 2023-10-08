#
# Responsavel por Combates Melee, Tiros e todo
# o resto do sistema de Combate.
# 
# Incluso estados, sinais, funções e variaveis
# para uso "global" do sistema
#
class_name CombatHandler extends Node2D

enum combats {
	MELEE, FIREARM
}
enum combatStates {
	PEACE, ATTACKING, DEFENDING
}
export(combats) var combat_status
export(combatStates) var currentCombatState

var meleeHandler = MeleeCombat.new()
var meleeAttackCount = 0
var meleeCollisionBody

func _physics_process(delta):
	if Input.is_action_just_pressed("gun_shoot"):
		if combat_status == combats.MELEE \
		and not $MeleeTimer.time_left \
		and meleeCollisionBody:
			meleeHandler._attack(meleeHandler.attacks.PUNCH)
			PlayerData.giveEnemyDamage(meleeCollisionBody.get_parent(), meleeHandler.damage_amount)
			$MeleeTimer.start()

#Callback Functions
func _on_MeleeCombatHandler_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	if area:
		meleeCollisionBody = area
func _on_MeleeCombatHandler_area_shape_exited(area_rid, area, area_shape_index, local_shape_index):
	if area:
		meleeCollisionBody = null
