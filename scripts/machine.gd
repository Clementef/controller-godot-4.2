extends Node3D
class_name Machine

@export var interface:DiegeticInterface
@export var action_map:Array[Action]

func _ready():
	if interface:
		interface.button_pressed.connect(_activate_machine)

func _activate_machine(id:int):
	if action_map.size()>id:
		if (action_map[id].target_id<get_child_count()):
			if get_child(action_map[id].target_id).has_method(action_map[id].callable_name):
				# everything exists, call the function
				var callable = Callable(get_child(action_map[id].target_id), action_map[id].callable_name)
				callable.call()
			else:
				print("call failed, method does not exist")
		else:
			print("child does not exist")
	else:
		print("action " + str(id) + " not mapped")
