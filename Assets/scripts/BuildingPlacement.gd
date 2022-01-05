extends Node2D

var placing = false
var building_path = ""
var building_size = 1.4 # number of tiles (square) the building will occupy
var selected_building = ""
var curr_scale

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _process(_delta):
	if placing:
		var setPosition = get_global_mouse_position()
		$BuildingSprite.position = setPosition
		if Input.is_action_just_pressed("Click"):
			var map = get_node("../TileMap")

			var top_left = map.world_to_map(setPosition * map.scale)
			if(map.get_cellv(top_left) != TileMap.INVALID_CELL):
				map.set_cellv(top_left, map.tile_set.get_tiles_ids().size()-1) #changing ground tiles, but offset!
				place_building(map.map_to_world(top_left));
			placing = false
			$BuildingSprite.texture = null
			
			

func set_building(building_name):
	placing = true
	selected_building = building_name
	building_path = building_name_to_texture_path(building_name)
	
	$BuildingSprite.texture = load(building_path)
	#TODO: un-magic number this.
	var size = Vector2(224,114) * building_size #Tilemap cell size, with building size included
	var scale_vec = size / $BuildingSprite.texture.get_size() #still a vector
	var scale = (scale_vec.y if scale_vec.x > scale_vec.y else scale_vec.x) - 0.02 #slightly smaller than the smaller scale value
	curr_scale = scale
	$BuildingSprite.scale.x = scale
	$BuildingSprite.scale.y = scale
	$BuildingSprite.self_modulate = Color(1,1,1,0.65)

func place_building(top_left_cell):
	var scene = preload("res://Object Scenes/Building.tscn")
	var instance = scene.instance()
	add_child(instance)
	instance.position = Vector2(top_left_cell.x-224, top_left_cell.y)
	instance.scale.x = curr_scale
	instance.scale.y = curr_scale
	#selected building, instantiate then call with name as parameter.
	return


func building_name_to_texture_path(building_name):
	var path = ""
	match building_name:
		"house1":
			path = "res://Assets/Buildings/house_1.png"
		"house2":
			path = "res://Assets/Buildings/house_2.png"
		"house3":
			path = "res://Assets/Buildings/house_3.png"
		"mall":
			path = "res://Assets/Buildings/Mall.png"
		"restaurant":
			var restaurant_choice = randi() % 3
			if restaurant_choice == 0:
				path = "res://Assets/Buildings/Ramenshop.png"
			elif restaurant_choice == 1:
				path = "res://Assets/Buildings/Hotdogstand.png"
			else:
				path = "res://Assets/Buildings/Grocerystore.png"
		"planetarium":
			path = "res://Assets/Buildings/Planetarium.png"
		"space_walk":
			path = "res://Assets/Buildings/MoonWalk.png"
		"bionics":
			path = "res://Assets/Buildings/Bionics.png"
		"observatory":
			path = "res://Assets/Buildings/Observatory.png"
		"biochem_lab":
			path = "res://Assets/Buildings/BioChemLab.png"
		"physics_lab":
			path = "res://Assets/Buildings/PhysicsLab.png"
		"satellite":
			path = "res://Assets/Buildings/SatelliteLauncher.png"
		"oxygen_tank":
			path = "res://Assets/Buildings/Oxygentree.png"
		"water_plant":
			path = "res://Assets/Buildings/WaterPlant.png"
		"power_plant":
			path = "res://Assets/Buildings/PowerStation.png"
		"greenhouse":
			path = "res://Assets/Buildings/greenhouse.png"
		"fab_lab":
			path = "res://Assets/Buildings/FabLab.png"
	return path