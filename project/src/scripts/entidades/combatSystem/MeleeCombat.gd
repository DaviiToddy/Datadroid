#
# Vide BaseCombat Class para verificar as funções
# do contrato.
#
# Melee Attack Combat Handler
#
class_name MeleeCombat extends BaseCombat

enum attacks {
	PUNCH, KICK
}
enum defenses {
	DODGE
}

const MELEE_PUNCH_COUNT = 0 #1
const MELEE_KICK_COUNT = 2 #3
const MELEE_PUNCH_DAMAGE = 20
const MELEE_KICK_DAMAGE = 40
const MELEE_DODGE_DEFENSE = 15

var meleeAttackCount = 0
var damage_amount = 0
var defense_amout = 0
var attackType: int = attacks.PUNCH
var defenseType: int = defenses.DODGE

#@Override
func _attack(): #attacksMelee
	if meleeAttackCount > MELEE_KICK_COUNT:
		pass #handle kick
		attackType = attacks.KICK
		damage_amount = MELEE_KICK_DAMAGE
		meleeAttackCount = 0
	else:
		pass #handle punch
		attackType = attacks.PUNCH
		damage_amount = MELEE_PUNCH_DAMAGE
		meleeAttackCount += 1

#@Override
func _defend():
	pass #handle dodge
	defenseType = attacks.DODGE
	defense_amout = MELEE_DODGE_DEFENSE
