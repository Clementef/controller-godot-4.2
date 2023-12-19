extends RayCast3D
const decal = preload("res://assets/bullet_hole/bullet_decal.tscn")

func cast_bullet_hole():
	if !is_colliding():
		return 1
	# instantiate and place bullet decal
	var _decal = decal.instantiate()
	get_collider().add_child(_decal)
	_decal.global_position = get_collision_point()
	_decal.look_at(get_collision_point()+get_collision_normal(),Vector3.UP) # align with normal
	_decal.transform.basis = Basis(Vector3.RIGHT, PI/2.) * _decal.transform.basis # rotate 90 on x
