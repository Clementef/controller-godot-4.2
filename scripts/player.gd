extends CharacterBody3D

@export var G = 15.
@export var speed = 5.
@export var sprint_speed = 8.
@export var acceleration = 10.
@export var jump_control = .15
@export var jump_height = .75
@onready var head = $head_rotation_h

var jump_vel:float
var effective_speed:float

func _ready():
	jump_vel = sqrt(2*G*jump_height)
	effective_speed = speed

func _physics_process(delta):
	# gravity and jump.
	if not is_on_floor():
		velocity.y -= G * delta
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_vel
	# directional movement
	var input_dir = Input.get_vector("left", "right", "forward", "backward")
	var direction = (head.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if is_on_floor():
		#sprint
		effective_speed = speed
		if Input.is_action_pressed("sprint") and (input_dir.y<0):
			effective_speed = sprint_speed
		# grounded input
		velocity.x = lerp(velocity.x,effective_speed*direction.x,acceleration*delta)
		velocity.z = lerp(velocity.z,effective_speed*direction.z,acceleration*delta)
	elif not direction.is_equal_approx(Vector3.ZERO):
		# in the air and giving input
		velocity.x = lerp(velocity.x,speed*direction.x,acceleration*jump_control*delta)
		velocity.z = lerp(velocity.z,speed*direction.z,acceleration*jump_control*delta)

	move_and_slide()
