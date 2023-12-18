extends Node
class_name GameObjectInputMap

@export var input_map:Dictionary = {"shoot": shoot(), "aim": aim()}

func shoot():
	print(name + " shoot")

func aim():
	print(name + " shoot")
