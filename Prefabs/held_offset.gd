extends Node3D

@export_group("recoil settings")
@export_subgroup("rotation_vertical")
@export var recoil_v_return_rate := 13.
@export_subgroup("rotation_roll")
@export var recoil_roll_return_rate := 10.
@export_subgroup("rotation_yaw")
@export var recoil_yaw_return_rate := 16.
@export_subgroup("impulse_forward")
@export var impulse_x_return_rate := 12.
@export_subgroup("impulse_vertical")
@export var impulse_y_return_rate := 7.
@export_subgroup("impulse_horizontal")
@export var impulse_z_return_rate := 9.

# local
var rot_x := 0.
var rot_z := 0.
var rot_y := 0.
var pos_x := 0.
var pos_y := 0.
var pos_z := 0.

func _process(delta):
	if !(rotation.is_zero_approx()):
		recoil_control(delta)

func add_recoil(recoil_v:float, recoil_roll:float, recoil_yaw:float,
				impulse_x:float, impulse_y:float, impulse_z:float):
	rot_x += recoil_v
	rot_z += recoil_roll * randf_range(-1,1)
	rot_y += recoil_yaw * randf_range(-1,1)
	pos_x += impulse_x
	pos_y += impulse_y
	pos_z += impulse_z * randf_range(-1,1)

func recoil_control(delta:float):
	rotation.x = lerp(rotation.x,rot_x,recoil_v_return_rate*delta)
	rot_x = lerp(rot_x,0.,recoil_v_return_rate*delta)
	rotation.z = lerp(rotation.z,rot_z,recoil_roll_return_rate*delta)
	rot_z = lerp(rot_z,0.,recoil_roll_return_rate*delta)
	rotation.y = lerp(rotation.y,rot_y,recoil_yaw_return_rate*delta)
	rot_y = lerp(rot_y,0.,recoil_yaw_return_rate*delta)
	position.z = lerp(position.z,pos_x,impulse_x_return_rate*delta)
	pos_x = lerp(pos_x,0.,impulse_x_return_rate*delta)
	position.y = lerp(position.y,pos_y,impulse_y_return_rate*delta)
	pos_y = lerp(pos_y,0.,impulse_y_return_rate*delta)
	position.x = lerp(position.x,pos_z,impulse_z_return_rate*delta)
	pos_z = lerp(pos_z,0.,impulse_z_return_rate*delta)
