extends RayCast3D

@onready var player_hud = $"../../../player_hud" as PlayerHud
@onready var camera = $"../camera"
@export var ray_length := 3

var item_selected := false
var colliding_with = null
var colliding_position = null

func _ready():
	target_position = Vector3(0,0,-ray_length)

func _physics_process(delta):
	var colliding := false
	if player_hud.fixed_mode:
		# fixed mode uses this raycast
		colliding = is_colliding()
	else:
		# free mouse mode generates raycast queries
		colliding_with = raycast_from_mouse(get_viewport().get_mouse_position(), self.collision_mask)
		if !colliding_with.is_empty():
			colliding = true
		else:
			colliding = false
	
	# set color
	player_hud.set_reticle_color(Color(1.,1.-int(colliding),1.-int(colliding)));
	
	# not colliding, clear hud
	if not colliding and item_selected:
		item_selected = false
		colliding_with = null
		colliding_position = null
		player_hud.set_item_attributes(null)
	# colliding, set hud
	if colliding:
		if player_hud.fixed_mode:
			colliding_with = get_collider()
			colliding_position = get_collision_point()
		else:
			colliding_position = colliding_with['position']
			colliding_with = colliding_with['collider']
		# do things for type of collider
		if colliding_with is GameObject:
			item_selected = true
			player_hud.set_item_attributes(colliding_with.item_data)
		elif colliding_with is DiegeticUI:
			#cursor.global_position = get_collision_point()
			var viewport_local = colliding_with.global_transform.affine_inverse()*colliding_position
			var viewport_point = Vector2(viewport_local.x,-viewport_local.y)
			#print("diegetic position " + str(viewport_point))
			# push origin to top left of mesh local space
			viewport_point.x += colliding_with.mesh.get_mesh().size.x / 2
			viewport_point.y += colliding_with.mesh.get_mesh().size.y / 2
			# normalize
			viewport_point.x = viewport_point.x / colliding_with.mesh.get_mesh().size.x
			viewport_point.y = viewport_point.y / colliding_with.mesh.get_mesh().size.y
			# rescale to viewport size
			viewport_point.x = viewport_point.x * colliding_with.viewport.size.x
			viewport_point.y = viewport_point.y * colliding_with.viewport.size.y
			# send new event to viewport
			var event := InputEventMouseMotion.new()
			event.position = viewport_point
			event.global_position = viewport_point
			colliding_with.viewport.push_input(event)

			if Input.is_action_just_pressed("interact"):
				var click_event := InputEventMouseButton.new()
				click_event.set_button_index(1)
				click_event.set_pressed(true)
				click_event.position = viewport_point
				click_event.global_position = viewport_point
				colliding_with.viewport.push_input(click_event)
			if Input.is_action_just_released("interact"):
				var click_event := InputEventMouseButton.new()
				click_event.set_button_index(1)
				click_event.set_pressed(false)
				click_event.position = viewport_point
				click_event.global_position = viewport_point
				colliding_with.viewport.push_input(click_event)
		else:
			print("object not compatible")
#
func raycast_from_mouse(m_pos, collision_mask):
	var ray_start = camera.project_ray_origin(m_pos)
	var ray_end = ray_start + camera.project_ray_normal(m_pos) * ray_length
	var world3d:World3D = get_world_3d()
	var space_state = world3d.direct_space_state
	
	if space_state == null:
		return
	
	var query = PhysicsRayQueryParameters3D.create(ray_start, ray_end, collision_mask)
	query.collide_with_areas = true
	return space_state.intersect_ray(query)
