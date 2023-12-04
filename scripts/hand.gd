extends Node3D
class_name Hand

@export var holding:GameObject = null

var input_map := {KEY_F: "interact",
				  KEY_G: "throw"}
var input := []

enum states {IDLE,REACHING,THROWING}
var state = states.IDLE
var reach_length = 1.

func _process(delta):
	match state:
		states.IDLE:
			pass
		states.REACHING:
			pass
		states.THROWING:
			pass

func process_inputs():
	# list of current inputs
	var inputs = []
	for input in input_map:
		if Input.is_physical_key_pressed(input):
			inputs.append(input_map[input])
	
	# process input
	for input in inputs:
		match input:
			"interact":
				print(name + " interact")
			"throw":
				print(name + " throw")
