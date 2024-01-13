extends RayCast3D
const decal = preload("res://assets/bullet_hole/bullet_decal.tscn")

func cast_bullet_hole():
	if !is_colliding():
		return 1
	# instantiate and place bullet decal
	var _decal = decal.instantiate()
	get_collider().add_child(_decal)
	
	# cache data
	var collision_pos = get_collision_point()
	var collision_normal = get_collision_normal()
	
	# place decal and rotate
	_decal.global_position = get_collision_point()
	if collision_normal != Vector3.UP:
		_decal.look_at(collision_pos+Vector3.UP, collision_normal)
	_decal.rotate(collision_normal, randf_range(0, 2*PI))
