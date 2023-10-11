#
# Vide BaseCombat Class para verificar as funções
# do contrato.
#
# FireArm Attack Combat Handler
#
class_name FireArmCombat extends BaseCombat

enum attacks {
	SHOOT, EXPLOSION, DETONATE
}
enum defenses {
	# Pode ser um escudo cibernetico ou 
	# simplesmente uma armadura de proteção.
	COVER
}

const FIRE_SHOOT_DAMAGE = 20

var meleeAttackCount = 0
var damage_amount = 0
var defense_amout = 0
var attackType: int = attacks.SHOOT
var defenseType: int = defenses.COVER

#@Override
func _attack():
	if attackType == attacks.SHOOT:
		damage_amount = FIRE_SHOOT_DAMAGE

#@Override
func _defend():
	pass
