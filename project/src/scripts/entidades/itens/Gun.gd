extends Resource

class_name Gun

export var ammo: int = 0
export var magazine_capacity: int = 0
export var magazine_ammo: int = 0
export var damage: int = 0

func _is_magazine_empty() -> bool:
	if magazine_ammo < 1: #still at least 1 bullet in the camber?
		return true
	return false

func _is_magazine_full() -> bool:
	if magazine_ammo == magazine_capacity: #magazine is full?
		return true
	return false

func _is_all_ammo_used() -> bool:
	if ammo - 1 < 0: #all the ammo was used?
		return true
	return false

func shoot():
	if _is_magazine_empty():
		return
	magazine_ammo -= 1 #1 bullet is fired and lost

func reload():
	for x in magazine_capacity:
		if _is_magazine_full():
			return
		if _is_all_ammo_used():
			return
		var bullet = 1 #
		ammo -= bullet #remove bullet of the ammo
		magazine_ammo += bullet #put the bullet in the magazine
