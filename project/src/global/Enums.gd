#
# Handles all possible global Enums
# Class Enums
#
extends Node

#GameEvents
enum GameRuntimeStates {
	GAMEPLAY, PAUSE, MENU
}

#Combat Controller
enum Combats {
	MELEE, FIREARM
}
enum CombatStates {
	PEACE, ATTACKING, DEFENDING
}
