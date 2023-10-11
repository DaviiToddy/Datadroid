#
# Classe utilizada como interface/classe-mãe
# pelas classes de Combate. (Meele, FireArm, Etc)
#
# Interface à ser implementada pelos combates.
#

#@Interface
class_name BaseCombat extends Node

#@Abstract func
func _attack():
	pass

#@Abstract func
func _defend():
	pass
