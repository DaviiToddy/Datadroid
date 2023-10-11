#
# Vide BaseCombat Class para verificar as funções
# do contrato.
#
# FireArm Attack Combat Handler
#
class_name FireArmCombat extends BaseCombat

enum attacks {
	SHOOT, EXPLODE, DETONATE
}
enum defenses {
	# Pode ser um escudo cibernetico ou 
	# simplesmente uma armadura de proteção.
	COVER
}

#@Override
func _attack():
	pass

#@Override
func _defend():
	pass
