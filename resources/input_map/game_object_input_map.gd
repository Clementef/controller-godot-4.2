extends Node3D
class_name GameObjectInputMap

var input_map:Dictionary = \
{
	"shoot": Callable(self, "shoot"),
	"shoot_release": Callable(self, "shoot_release"),
	"aim": Callable(self, "aim"),
	"aim_release": Callable(self, "aim_release"),
	"reload": Callable(self, "reload"),
	"reload_release": Callable(self, "reload_release"),
}

@export var enable_all_recoil := true
@export_group("recoil settings")
@export_subgroup("vertical")
@export var enable_recoil_v := false
@export_subgroup("roll")
@export var enable_recoil_roll := false
@export_subgroup("yaw")
@export var enable_recoil_yaw := false
@export_subgroup("impulse_x")
@export var enable_impulse_x := false
@export_subgroup("impulse_y")
@export var enable_impulse_y := false
@export_subgroup("impulse_z")
@export var enable_impulse_z := false

signal recoil(recoil_v:float, recoil_roll:float, recoil_yaw:float,
				impulse_x:float, impulse_y:float, impulse_z:float)

func shoot():
	print(name + " default input function for: shoot")
func shoot_release():
	print(name + " default input function for: shoot_release")

func aim():
	print(name + " default input function for: aim")
func aim_release():
	print(name + " default input function for: aim_release")

func reload():
	print(name + " default input function for: reload")
func reload_release():
	print(name + " default input function for: reload_release")
