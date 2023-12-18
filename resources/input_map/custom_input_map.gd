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

func shoot():
	recoil.emit(recoil_v,recoil_roll,recoil_yaw,
				impulse_x,impulse_y,impulse_z)

func shoot_release():
	print("custom shoot release function")
