extends Node3D
class_name Hand

@export var hand_speed := 5.
@export var throw_force_magnitude := 200.
@export var held_item:GameObject
@onready var player = $"../../.."
@onready var hand_position = $idle_offset/held_offset
@onready var interactor = $"../../head_rotation_h/head_rotation_v/interactor"

var gameobject_inputs:Array[String] = ["aim", "shoot", "reload"]
var idle_position:Vector3
var reach_length = 1.
var target = null

func _ready():
	if held_item:
		held_item.set_physics(false)

func process_inputs():
	# native hand inputs
	if Input.is_action_just_pressed("interact"):
		interact()
	if Input.is_action_just_pressed("throw"):
		throw()
	# game object inputs
	# exit if no held item
	if !held_item:
		return
	# process inputs
	for input in gameobject_inputs:
		gameobject_map(input)

func gameobject_map(input:String):
	if Input.is_action_just_pressed(input):
		held_item.process_input(input)
	if Input.is_action_just_released(input):
		held_item.process_input(input + "_release")

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
				collision.position = Vector3.ZERO
				collision.rotation = Vector3.ZERO
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
