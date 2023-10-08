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

var damage_amount = 0
var defense_amout = 0

#@Override
func _attack(attackType: int): #attacksMelee
	if attackType == attacks.PUNCH:
		pass #handle punch
		damage_amount = 20
	elif attackType == attacks.KICK:
		pass #handle kick
		damage_amount = 40

#@Override
func _defend(defenseType: int):
	if defenseType == attacks.DODGE:
		pass #handle dodge
