extends Resource
class_name ItemData
enum item_types {CONSUMABLE,INTERACTIVE,NONE=-1}

@export var name := "item"
@export var type := item_types.NONE
