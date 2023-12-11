extends CanvasLayer
class_name PlayerHud

@onready var reticle = $Control/reticle as TextureRect
@onready var item_name = $Control/MarginContainer/MarginContainer/VBoxContainer/HBoxContainer/item_name
@onready var item_type = $Control/MarginContainer/MarginContainer/VBoxContainer/HBoxContainer2/item_type
@onready var item_panel = $Control/MarginContainer

var item_type_lookup := {0:"Consumable",1:"Interactive",-1:"None"}
var center_position:Vector2
var fixed_mode := true

func _ready():
	item_panel.visible = false
	center_position = reticle.position
	update_mode()

func _process(delta):
	if Input.is_action_just_pressed("toggle_mouse_mode"):
		fixed_mode = !fixed_mode
		update_mode()
	if !fixed_mode:
		reticle.position = get_viewport().get_mouse_position()

func update_mode():
	if fixed_mode:
		reticle.position = center_position
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

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
