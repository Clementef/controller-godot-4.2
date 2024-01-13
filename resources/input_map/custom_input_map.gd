extends GameObjectInputMap

@export_group("recoil settings")
@export_subgroup("rotation_vertical")
@export var recoil_v := 1.
@export_subgroup("rotation_roll")
@export var recoil_roll := .25
@export_subgroup("rotation_yaw")
@export var recoil_yaw := .2
@export_subgroup("impulse_forward")
@export var impulse_x := .08
@export_subgroup("impulse_vertical")
@export var impulse_y := .05
@export_subgroup("impulse_horizontal")
@export var impulse_z := .03

@onready var barrel_raycast = $barrel_raycast

func shoot():
	# add recoil
	recoil.emit(recoil_v,recoil_roll,recoil_yaw,
				impulse_x,impulse_y,impulse_z)
	# cast bullet
	barrel_raycast.cast_bullet_hole()
	# exit if barrel raycast not colliding
	if !barrel_raycast.is_colliding():
		print("no bullet collision")
		return
	# do something with raycast data
	print(barrel_raycast.get_collision_point())
