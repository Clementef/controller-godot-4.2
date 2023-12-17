extends AnimatableBody3D

@onready var animation = $animation
var elevator_forward = true

func next_stop():
	if elevator_forward:
		animation.play("next_stop",-1,1,false)
	else:
		animation.play("next_stop",-1,-1,true)
	elevator_forward = !elevator_forward
