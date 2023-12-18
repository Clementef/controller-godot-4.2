extends RigidBody3D
class_name GameObject

@export var physics_activated := true
@export var item_data:ItemData = ItemData.new() as ItemData
@onready var collider = $collider
@onready var smoothing = $"Smoothing" as Smoothing 
@onready var mesh = $Smoothing.get_child(0)
var input_map:GameObjectInputMap
var mesh_smoothing := true
const smoothing_setting := 7

# only called when all children ready
func _ready():
	# set physics state
	set_physics(physics_activated)
	# find optional child nodes
	for child in get_children():
		if child is GameObjectInputMap:
			input_map = child
			child.recoil.connect(self.add_recoil)

func add_recoil(recoil_v:float, recoil_roll:float, recoil_yaw:float,
				impulse_x:float, impulse_y:float, impulse_z:float):
	get_parent().add_recoil(recoil_v,recoil_roll,recoil_yaw,
							impulse_x,impulse_y,impulse_z)

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
