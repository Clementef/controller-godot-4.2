extends Node3D
class_name GameObject

@export var physics_activated := false
@export var item_data:ItemData
@onready var collider = $collider

func _ready():
	set_physics(physics_activated)

func set_physics(b:bool):
	self.freeze = !b
	collider.disabled = !b
