extends CanvasLayer
class_name PlayerHud

@onready var reticle = $Control/reticle as TextureRect
@onready var item_name = $Control/MarginContainer/MarginContainer/VBoxContainer/HBoxContainer/item_name
@onready var item_type = $Control/MarginContainer/MarginContainer/VBoxContainer/HBoxContainer2/item_type
@onready var item_panel = $Control/MarginContainer

var item_type_lookup := {0:"Consumable",1:"Interactive",-1:"None"}

func _ready():
	item_panel.visible = false

func set_reticle_color(col:Color):
	reticle.self_modulate = col

func set_item_attributes(item:ItemData):
	if item == null:
		item_panel.visible = false
		item_name.text = ""
		item_type.text = ""
		return 1
	item_panel.visible = true
	item_name.text = item.name
	item_type.text = item_type_lookup[item.type]
