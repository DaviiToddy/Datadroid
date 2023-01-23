class_name Collectable extends Area2D

enum TYPES {
	INFO, COLLECTABLE, CONSUMABLE
}

export(TYPES) var collect_type

func _ready() -> void:
	setup(collect_type)

func setup(type: int):
	pass

func reaction():
	pass

func _on_Collectable_body_entered(body: Player) -> void:
	if body:
		reaction()

func _on_Collectable_body_exited(body: Player) -> void:
	if body:
		pass
