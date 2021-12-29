extends Resource
class_name itemResource

# Item template class.
# To create a new item definition. Go to the FileSystem panel, navigate to 
# scenes>item_definitions, right click, New resource.
# Type in itemresource and click Item.gd... Name your file and save.
# Once created, on the right side of the game engine in Inspector,
# add your item name, stackable boolean, stack size, and item type. Done!

export var name : String
export var stackable : bool = false
export var max_stack_size : int = 1

enum itemType { GENERIC, CONSUMABLE, MISSION }
export(itemType) var type
