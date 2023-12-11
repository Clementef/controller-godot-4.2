extends Node3D
@export var sens := 1.;
@export var vertical_margin := 0.01;
@onready var player_hud = $"../player_hud"
@onready var head_rotation_v := $head_rotation_v
var true_sens := 0.
# accumulators
var rot_x := 0.
var rot_y := 0.
const halfpi := PI/2.

func _ready():
	true_sens = sens/500.

func _input(event):
	if player_hud.fixed_mode == true:
		if event is InputEventMouseMotion:
			# modify accumulated mouse rotation
			rot_x -= event.relative.x * true_sens
			rot_y -= event.relative.y * true_sens
			rot_y = clamp(rot_y,-halfpi+vertical_margin,halfpi-vertical_margin)
			transform.basis = Basis() # reset rotation
			head_rotation_v.transform.basis = Basis()
			rotate_object_local(Vector3(0, 1, 0), rot_x) # first rotate in Y
			head_rotation_v.rotate_object_local(Vector3(1, 0, 0), rot_y) # then rotate in X
