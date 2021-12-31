extends Node

var items = Array()

func _ready():
	
	var directory = Directory.new()
	directory.open("res://scenes/item_definitions")
	directory.list_dir_begin()
	
	#grab all items from scenes/item_definitions and save them in an array
	var filename = directory.get_next()
	print("ITEMS LOADED:")
	while(filename):
		if not directory.current_is_dir():
			print(filename)
			items.append(load("res://scenes/item_definitions/%s" % filename))
		
		filename = directory.get_next()

#return item from array
func getItem(itemName):
	for i in items:
		if i.name == itemName:
			return i
	return null
