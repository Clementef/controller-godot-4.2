extends Node3D

@export var rotate_rate := 30.
@export_group("hand idle")
@export var hands_idle_separation := .8
@export var hands_distance := 1.
@export var hands_distance_below_eyes := .4
@onready var camera = $"../head_rotation_h/head_rotation_v/camera"

@onready var left_hand = $left_hand
@onready var right_hand = $right_hand

var hands:Array
var idle_position:Vector3
var idle_position_2:Vector3

func _ready():
	idle_position = Vector3(-hands_idle_separation/2.,-hands_distance_below_eyes,-hands_distance)
	idle_position_2 = Vector3(hands_idle_separation/2.,-hands_distance_below_eyes,-hands_distance)
	right_hand.position = idle_position_2
	right_hand.idle_position = idle_position_2

func _process(delta):
	# Convert basis to quaternion, scale is lost
	var a = Quaternion(global_transform.basis)
	var b = Quaternion(camera.global_transform.basis)
	var c = a.slerp(b,rotate_rate*delta) # spherical interpolate between a and b
	transform.basis = Basis(c) # Apply back
