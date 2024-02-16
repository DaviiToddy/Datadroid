# Sistemas, Comportamentos e Interação do Player em
# uma espécie de Mochila do Player para utilização dos dados.
# 
# Introdução à implementações futuras como Save e Load.
#
# class_name PlayerData

extends Node

signal CallGameOver

const PLAYER_MAX_HP = 100

#Baseado na arma, depende do player. (Hardcode values temp)
export var playerHP: = PLAYER_MAX_HP
# Implementação futura para o Robot ~Sem nome por enquanto
# var robotHP: = ROBOT_MAX_HP

func takePlayerDamage(damage_amount: float) -> void:
	if playerHP - damage_amount <= 0:
		emit_signal("CallGameOver")
	playerHP -= damage_amount

func giveEnemyDamage(enemy: EnemyMock, damage_amount: float) -> void:
	#Enemy recebe Dano.
	#Está vazio pois Enemy não foi implementado ainda.
	if enemy and not enemy.is_queued_for_deletion():
		enemy.takeDamage(damage_amount)

