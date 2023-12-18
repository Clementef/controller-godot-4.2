extends Node3D
class_name Machine

@export var interfaces:Array[DiegeticInterface]
@export var action_map:Array[Action]

func _ready():
	for interface in interfaces:
		interface.button_pressed.connect(_activate_machine)

func _activate_machine(id:int):
	# exit if action is not mapped
	if !(action_map.size()>id):
		print("action " + str(id) + " not mapped")
		return
	# exit if target does not exist
	if !(action_map[id].target_id<get_child_count()):
		print("child does not exist")
		return
	# exit if method does not exist
	if !get_child(action_map[id].target_id).has_method(action_map[id].callable_name):
		print("call failed, method does not exist")
		return
	# everything exists, call the function
	var callable = Callable(get_child(action_map[id].target_id), action_map[id].callable_name)
	callable.call()
