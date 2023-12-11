extends Node3D

@onready var left_hand = $"../left_hand"
@onready var right_hand = $"../right_hand"
var input_map:Dictionary

func _ready():
	input_map = {"left_hand": left_hand, "right_hand": right_hand}

func _process(delta):
	for input in input_map:
		if Input.is_action_pressed(input):
			input_map[input].process_inputs()
