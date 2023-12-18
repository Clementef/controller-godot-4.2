extends Node3D

@export var enable_all_recoil := true
@export_group("recoil bools")
@export var enable_recoil_v := false
@export var enable_recoil_roll := false
@export var enable_recoil_yaw := false
@export var enable_impulse_x := false
@export var enable_impulse_y:= false
@export var enable_impulse_z := false
@export_group("recoil settings")
@export_subgroup("rotation_vertical")
@export var recoil_v := 1.
@export_subgroup("rotation_roll")
@export var recoil_roll := .25
@export_subgroup("rotation_yaw")
@export var recoil_yaw := .1
@export_subgroup("impulse_forward")
@export var impulse_x := .08
@export_subgroup("impulse_vertical")
@export var impulse_y := .05
@export_subgroup("impulse_horizontal")
@export var impulse_z := .03

@onready var held_offset = $"../"
