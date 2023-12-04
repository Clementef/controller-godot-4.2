extends RayCast3D

@onready var player_hud = $"../../../player_hud" as PlayerHud

var item_selected := false

func _physics_process(delta):
	var colliding := is_colliding()
	player_hud.set_reticle_color(Color(1.,1.-int(colliding),1.-int(colliding)));
	if not colliding and item_selected:
		item_selected = false
		player_hud.set_item_attributes(null)
	
	if colliding:
		var colliding_with := get_collider()
		if colliding_with is GameObject:
			item_selected = true
			player_hud.set_item_attributes(colliding_with.item_data)
		else:
			print("not game object")
