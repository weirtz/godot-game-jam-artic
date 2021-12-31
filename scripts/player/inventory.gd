extends Resource
class_name inventory

signal inventory_changed

export var _items = Array() setget set_items, get_items

#--------------------
# setters and getters

func set_items(new_items):
	_items = new_items
	emit_signal("inventory_changed", self)
	
func get_items():
	return _items
	
func get_item(index):
	return _items[index]

func remove_item(item_name, quantity):
	for i in range(_items.size()):
		var item = ItemDatabase.getItem(item_name)
		var inventory_item = _items[i]
		if inventory_item.item_reference.name != item.name:
			continue
			
		inventory_item.quantity = inventory_item.quantity - quantity
	emit_signal("inventory_changed", self)
	
# add item to inventory, supply with the item name and quantity
func add_item(item_name, quantity):
	if quantity <= 0:
		print("cant add negative number of items")
		return
		
	var item = ItemDatabase.getItem(item_name)
	if not item:
		print("could not find item")
		return
	
	var remaining_quantity = quantity
	var max_stack_size = item.max_stack_size if item.stackable else 1
	
	#stackabale items
	#checks item quantity and compares it to max stack size vs existing inventory and splits acordingly.
	if item.stackable:
		for i in range(_items.size()):
			if remaining_quantity == 0:
				break
				
			var inventory_item = _items[i]
			
			if inventory_item.item_reference.name != item.name:
				continue
			
			if inventory_item.quantity < max_stack_size:
				var original_quantity = inventory_item.quantity
				inventory_item.quantity = min(original_quantity + remaining_quantity, max_stack_size)
				remaining_quantity -= inventory_item.quantity - original_quantity
			
	while remaining_quantity > 0:
		var new_item = {
			item_reference = item,
			quantity = min(remaining_quantity, max_stack_size)
		}
		_items.append(new_item)
		remaining_quantity -= new_item.quantity
		
	emit_signal("inventory_changed", self)

