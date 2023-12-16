extends RigidBody3D
class_name GameObject

@export var physics_activated := true
@export var item_data:ItemData
@onready var collider = $collider
@onready var smoothing = $"Smoothing" as Smoothing 
@onready var mesh = $Smoothing/mesh
var mesh_smoothing := true
const smoothing_setting := 7

func _ready():
	set_physics(physics_activated)

func set_physics(b:bool):
	freeze = !b
	collider.disabled = !b
	smoothing.flags = int(b)*smoothing_setting
	if b and !mesh_smoothing:
		# move mesh into smoothing
		smoothing.set_enabled(true)
		remove_child(mesh)
		smoothing.add_child(mesh)
		mesh_smoothing = true
	elif !b and mesh_smoothing:
		# move mesh out of smoothing
		smoothing.set_enabled(false)
		smoothing.remove_child(mesh)
		add_child(mesh)
		mesh_smoothing = false
