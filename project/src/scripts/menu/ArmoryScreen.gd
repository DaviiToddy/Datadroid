extends Control

var inventory = {
	"Pistol" : {
		"texture_path": "res://src/assets/sprites/armory/guns/robot_guns_3.png",
		"ammo": 90,
		"capacity": 12,
	},
	"M9" : {
		"texture_path": "res://src/assets/sprites/armory/guns/robot_guns_3.png",
		"ammo": 90,
		"capacity": 12,
	},
	"Rifle" : {
		"texture_path": "res://src/assets/sprites/armory/guns/robot_guns_1.png",
		"ammo": 90,
		"capacity": 30,
	},
	"M4A1" : {
		"texture_path": "res://src/assets/sprites/armory/guns/robot_guns_1.png",
		"ammo": 90,
		"capacity": 30,
	},
	"SMG" : {
		"texture_path": "res://src/assets/sprites/armory/guns/robot_guns_4.png",
		"ammo": 90,
		"capacity": 30,
	},
	"MP5" : {
		"texture_path": "res://src/assets/sprites/armory/guns/robot_guns_4.png",
		"ammo": 90,
		"capacity": 30,
	}
}

onready var list = $HBoxContainer/Menu/Gun/HBoxContainer

func _ready() -> void:
	$AnimationPlayer.play_backwards("popup_menu")
	
	for item in inventory:
		var name = item
		var path = inventory[item]["texture_path"]
		list.add_item(name, load(path))

func show():
	$AnimationPlayer.play("popup_menu")
	.show()

func _on_HBoxContainer_item_activated(index: int):
	$PopupDialog/Label.text = str(list.get_item_text(index), " is selected!")
	$PopupDialog.popup()

func _on_Button_pressed() -> void:
	$AnimationPlayer.play_backwards("popup_menu")
	get_parent()._changeScreen("title")

func _on_Button_select_pressed() -> void:
	if list.get_selected_items():
		var index = list.get_selected_items()[0]
		$PopupDialog/Label.text = str(list.get_item_text(index), " is selected!")
		$PopupDialog.popup()
	else:
		$PopupDialog/Label.text = "You haven't selected any item"
		$PopupDialog.popup()
