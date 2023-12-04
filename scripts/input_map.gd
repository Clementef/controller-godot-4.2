extends Node3D

@onready var left_hand = $"../left_hand"
@onready var right_hand = $"../right_hand"
var input_map:Dictionary
var input:Array

func _ready():
	input_map = {KEY_Z: left_hand,
  	 			 KEY_X: right_hand} #defined in ready due to node references

func _process(delta):
	# list of current modifiers
	var inputs = []
	for input in input_map:
		if Input.is_physical_key_pressed(input):
			input_map[input].process_inputs()
