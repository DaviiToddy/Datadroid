extends Node2D

var items = []

func add_item(item) -> void:
	items.append(item)

func remove_item(item_obj = null) -> void:
	var item_validation_idx: int = _validate_item(item_obj)
	if not item_validation_idx < 0:
		items.remove(item_validation_idx)

func get_item(item_obj = null) -> Object:
	var item_validation_idx: int = _validate_item(item_obj)
	if not item_validation_idx < 0:
		return items[item_validation_idx]
	return null

func _validate_item(item_obj = null) -> int:
	if !item_obj:
		return -1
	var searched_item_idx = items.find(item_obj)
	if searched_item_idx < 0: #Meaning its -1. (aka not a valid idx)
		return -1
	return searched_item_idx

func _ready() -> void:
	pass
	#test()

#func test():
#	var mock_item = "Hello My Man"
#	var mock_item2 = "Foolish Hearth"
#
#	add_item(mock_item) #Add mock to list
#	print(items)
#
#	add_item(mock_item2) #Add mock2 to list
#	print(items)
#
#	var test_item = get_item(mock_item) #Return mock obj
#	print(test_item)
#
#	var test_item2 = get_item(mock_item2) #Return mock2 obj
#	print(test_item2)
#
#	print(items) #Print List default (Without sorting)
#
#	items.sort() #List is sorted
#	print(items) #Print List sorted
#
#	remove_item(mock_item) #Remove - valid call
#	print(items)
#
#	remove_item(mock_item) #Remove - invalid call
#	print(items)
#
#	remove_item(mock_item2) # Remove - valid call
#	print(items)
#
#Mocked items array
#var items = [
#	"abc",
#	30,
#	{
#		"Name": "Edu",
#		"Idade": 120.10,
#		"Genero": "Prefiro Nao Dizer..."
#	}
#]
