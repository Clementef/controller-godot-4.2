extends Control

signal button_pressed(id)

func _ready():
	button_pressed.connect(owner._button_pressed)

func _button_pressed(id:int):
	button_pressed.emit(id)
