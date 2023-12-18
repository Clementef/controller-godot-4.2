extends RigidBody3D
class_name GameObject

@export var physics_activated := true
@export var item_data:ItemData
@onready var collider = $collider
@onready var smoothing = $"Smoothing" as Smoothing 
@onready var mesh = $Smoothing.get_child(0)
@onready var held_offset = $"../"
var mesh_smoothing := true
const smoothing_setting := 7
@onready var input_map:GameObjectInputMap

func gameobject_input(input:String):
	# exit if not input map
	if input_map == null:
		print("no input map")
		return
	# exit if action is not mapped
	if !(input in input_map):
		print("action " + input + " not mapped")
		return
	# exit if method does not exist
	if !self.has_method(input):
		print("call failed, method does not exist")
		return
	# everything exists, call the function
	var callable = Callable(self, input)
	callable.call()

func _ready():
	for child in get_children():
		if child is GameObjectInputMap:
			input_map = child
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
