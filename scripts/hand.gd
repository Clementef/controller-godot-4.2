extends Node3D
class_name Hand

@export var holding:GameObject = null
@export var hand_speed := 5.
@export var throw_force_magnitude := 200.
@onready var player = $"../../.."
@onready var hand_position = $idle_offset/held_offset
@onready var interactor = $"../../head_rotation_h/head_rotation_v/interactor"

var held_item = null
var reach_length = 1.
var idle_position:Vector3
var target = null

func process_inputs():
	if Input.is_action_just_pressed("interact"):
		interact()
	if Input.is_action_just_pressed("throw"):
		throw()

func interact():
	if interactor.colliding_with != null:
		# cases for different types of objects
		var collision = interactor.colliding_with
		if collision is GameObject:
			# check if not already holding
			if held_item == null:
				# pick up item
				held_item = collision
				collision.set_physics(false)
				#reparent and set position
				collision.get_parent().remove_child(collision)
				collision.global_position = Vector3.ZERO
				collision.global_rotation = Vector3.ZERO
				hand_position.add_child(collision)
			else:
				print(name + " already holding " + held_item.item_data.name)

func throw():
	# only throw if currently holding
	if held_item != null:
		# store global transform
		var gpos = held_item.global_position
		var grot = held_item.global_rotation
		# reparent 
		hand_position.remove_child(held_item)
		get_tree().root.add_child(held_item)
		# set global transform and linear velocity
		held_item.global_position = gpos
		held_item.global_rotation = grot
		held_item.linear_velocity = player.velocity
		# add to simulation and apply throw force
		held_item.set_physics(true)
		held_item.apply_central_force((global_transform.basis * Vector3(0, 0, -throw_force_magnitude)))
		# update state and held_item
		held_item = null
