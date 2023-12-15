extends Node3D
class_name DiegeticInterface

signal button_pressed(id:int)

func _button_pressed(id:int):
	button_pressed.emit(id)
