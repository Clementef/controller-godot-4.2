extends Node

func _input(event):
	if event.is_action_pressed("reload"):
		get_tree().reload_current_scene()
	if event.is_action_pressed("quit"):
		get_tree().quit()
