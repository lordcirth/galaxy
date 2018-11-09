extends Spatial

var UP = Vector3(0,0,1)

var star_scene = preload("res://scenes/Star.tscn")
var star_node

var fleet_scene = preload("res://scenes/Fleet.tscn")
var fleet_node

# Generate galaxy map by spawning Star instances
func _ready():
	var sol = new_star("Sol", Vector3(0,0,0))
	var centauri = new_star("Centauri", Vector3(8,0,0))
	
	var squadron = new_fleet("Squadron", Vector3(0,0,0))
	move_fleet(squadron, centauri)

func _fixed_process(delta):
	pass

func new_star(name, position):
	star_node = star_scene.instance()
	star_node.name = name
	star_node.translate(position)
	add_child(star_node)
	return star_node

func new_fleet(name, position):
	fleet_node = fleet_scene.instance()
	fleet_node.name = name
	fleet_node.translate(position)
	fleet_node.global_scale(Vector3(0.5,0.5,0.5))
	add_child(fleet_node)
	return fleet_node

func move_fleet(fleet, destination):
	var dest_pos = destination.get_global_transform().origin
	var fleet_pos = fleet.get_global_transform().origin
	print("dest_pos: " + String(dest_pos))
	print("fleet_pos: " + String(fleet_pos))
	var dir = dest_pos - fleet_pos
	fleet.look_at(dest_pos, UP)
	fleet.global_translate(dir*1)