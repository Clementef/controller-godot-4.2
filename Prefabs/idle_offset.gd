extends Node3D
@export var enable_displacement := true
@export var enable_rotation := true
@export var max_displacement := .01
@export var max_rotation := .07
@export var anim_timescale := 3.
@export var custom_offset = 0.
@export var idle_noise:FastNoiseLite
var x := 0.
const y := 1000.
const z := 2000.
const rx := 3000.
const ry := 4000.
const rz := 5000.

func _process(delta):
	if enable_displacement:
		position.x = 2. * max_displacement * idle_noise.get_noise_1d(x+custom_offset) - max_displacement
		position.y = 2. * max_displacement * idle_noise.get_noise_1d(x+custom_offset+y) - max_displacement
		position.z = 2. * max_displacement * idle_noise.get_noise_1d(x+custom_offset+z) - max_displacement
	if enable_rotation:
		rotation.x = 2. * max_rotation * idle_noise.get_noise_1d(x+custom_offset+rx) - max_displacement
		rotation.y = 2. * max_rotation * idle_noise.get_noise_1d(x+custom_offset+ry) - max_displacement
		rotation.z = 2. * max_rotation * idle_noise.get_noise_1d(x+custom_offset+rz) - max_displacement
	x += delta * anim_timescale
