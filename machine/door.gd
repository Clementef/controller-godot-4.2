extends AnimatableBody3D
@onready var mesh = $Smoothing/mesh
@onready var animation = $animation
var elevator_forward = true

func toggle_visible():
	visible = !visible

func random_color():
	mesh.get_active_material(0).albedo_color = Color.from_hsv(randf(),1.,1.)

func next_stop():
	if elevator_forward:
		animation.play("move_elevator",-1,1,false)
	else:
		animation.play("move_elevator",-1,-1,true)
	elevator_forward = !elevator_forward
