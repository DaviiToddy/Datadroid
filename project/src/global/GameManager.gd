extends Node

var gameState: Enums

func _init() -> void:
	print("Instanciated")

func _ready() -> void:
	print("Ready to Go")
	gameState = Enums.GameRuntimeStates.MENU
