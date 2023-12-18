extends RayCast3D

@onready var player_hud = $"../../../../player_hud" as PlayerHud
@onready var camera = $"../camera"
@export var ray_length := 3

var item_selected := false
var colliding_with = null
var colliding_position = null
var raycast_query_data = null

func _ready():
	target_position = Vector3(0,0,-ray_length)

func _physics_process(delta):
	# update raycast and cache data
	var colliding := get_raycast()
	
	# reset reticle color and clear hud
	player_hud.set_reticle_color(Color(1.,1.,1.))
	player_hud.set_item_attributes(null)
	
	if !colliding:
		return
	
	# colliding, set hud
	colliding_with = null
	colliding_position = null
	get_collision_data()
	# do things for type of collider
	if colliding_with is GameObject:
		gameobject_interact()
	elif colliding_with is DiegeticUI:
		diegetic_interact()

func get_raycast() -> bool:
	# raycast
	match player_hud.fixed_mode:
		true:
			# fixed mode uses this node to raycast
			return is_colliding()
		false: # can only be false
			# free mouse mode generates raycast queries
			raycast_query_data = raycast_from_mouse(get_viewport().get_mouse_position(), self.collision_mask)
			return !raycast_query_data.is_empty()
		_: # should never get here
			return false

func get_collision_data() -> void:
	match player_hud.fixed_mode:
		true:
			colliding_with = get_collider()
			colliding_position = get_collision_point()
		false:
			colliding_position = raycast_query_data['position']
			colliding_with = raycast_query_data['collider']

func gameobject_interact() -> void:
	# game objects get magenta reticle
	player_hud.set_reticle_color(Color(1.,0.,1.));
	# update hud
	player_hud.set_item_attributes(colliding_with.item_data)

func diegetic_interact() -> void:
	# ui get red reticle
	player_hud.set_reticle_color(Color(1.,0.,0.));
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

func raycast_from_mouse(m_pos, collision_mask) -> Dictionary:
	var ray_start = camera.project_ray_origin(m_pos)
	var ray_end = ray_start + camera.project_ray_normal(m_pos) * ray_length
	var world3d:World3D = get_world_3d()
	var space_state = world3d.direct_space_state
	
	if space_state == null:
		return {}
	
	var query = PhysicsRayQueryParameters3D.create(ray_start, ray_end, collision_mask)
	query.collide_with_areas = true
	return space_state.intersect_ray(query)
