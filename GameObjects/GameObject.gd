extends RigidBody3D
class_name GameObject

@export var physics_activated := true
@onready var collider = $collider
@onready var smoothing = $"Smoothing" as Smoothing 
@onready var mesh = $Smoothing.get_child(0)
@onready var held_offset = $"../"
var mesh_smoothing := true
const smoothing_setting := 7

@export var item_data:ItemData = ItemData.new() as ItemData
var input_map:GameObjectInputMap

# only called when all children ready
func _ready():
	set_physics(physics_activated)
	for child in get_children():
		if child is GameObjectInputMap:
			#print(name + " input map found")
			input_map = child
	#print(input_map.name)

func process_input(input:String):
	# exit if no input map
	if !input_map:
		print("no input map")
		return
	# exit if input not mapped
	if !(input in input_map):
		print("input not mapped")
		return
	# input map is dictionary { string: Callable }
	# map and input exist, call mapped callable
	input_map.input_map[input].call()

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
