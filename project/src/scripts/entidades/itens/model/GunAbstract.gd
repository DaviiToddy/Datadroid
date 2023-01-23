class_name GunAbstract extends Node

export var ammo: int = 0
export var magazine_max_capacity: int = 0
export var magazine_ammo: int = 0
export var damage: int = 0

func _is_magazine_empty() -> bool:
	if magazine_ammo < 1: #still at least 1 bullet in the camber?
		return true
	return false

func _is_magazine_full() -> bool:
	if magazine_ammo == magazine_max_capacity: #magazine is full?
		return true
	return false

func _is_all_ammo_used() -> bool:
	if ammo - 1 < 0: #all the ammo was used?
		return true
	return false

func _is_possible_to_shoot() -> bool:
	if _is_magazine_empty():
		return false
	return true

func shoot():
	if _is_possible_to_shoot():
		magazine_ammo -= 1 #1 bullet is fired and lost ammo.

func reload():
	for x in magazine_max_capacity:
		if _is_magazine_full():
			return
		if _is_all_ammo_used():
			return
		var bullet = 1 #
		ammo -= bullet #remove bullet of the ammo
		magazine_ammo += bullet #put the bullet in the magazine
