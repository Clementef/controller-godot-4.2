extends RayCast3D

@onready var player_hud = $"../../../player_hud" as PlayerHud
@onready var camera = $"../camera"
@export var ray_length := 3

var item_selected := false
var colliding_with = null

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
		player_hud.set_item_attributes(null)
	# colliding, set hud
	if colliding:
		if player_hud.fixed_mode:
			colliding_with = get_collider()
		else:
			colliding_with = colliding_with['collider']
		if colliding_with is GameObject:
			item_selected = true
			player_hud.set_item_attributes(colliding_with.item_data)
		else:
			print("not game object")
#
func raycast_from_mouse(m_pos, collision_mask):
	var ray_start = camera.project_ray_origin(m_pos)
	var ray_end = ray_start + camera.project_ray_normal(m_pos) * ray_length
	var world3d : World3D = get_world_3d()
	var space_state = world3d.direct_space_state
	
	if space_state == null:
		return
	
	var query = PhysicsRayQueryParameters3D.create(ray_start, ray_end, collision_mask)
	query.collide_with_areas = true
	
	return space_state.intersect_ray(query)
