extends Node2D

var placing = false
var building_path = ""
var building_size = 1 # number of tiles (square) the building will occupy
var building_xp = 0
var building_cost = 0
var building_upkeep = 0
var building_profit = 0
var building_type = ""
var building_pop_support = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _process(delta):
	if placing:
		var offset = Vector2(0,0)
		position = get_global_mouse_position()
		if Input.is_action_just_pressed("Click"):
			var map = get_node("../TileMap")
			print("world position" + str(position))
			print("map position for that position: " + str(map.world_to_map(position)))
			print("world position for that map position: " + str(map.map_to_world((map.world_to_map(position)))))
			print("corrected world position: " + str(position * get_node("../Camera2D").zoom))
			print("corrected map position: " + str(map.world_to_map(position * get_node("../Camera2D").zoom)))
			print("corrected world position fro that map position: " + str(map.map_to_world((map.world_to_map(position * get_node("../Camera2D").zoom + get_node("../Camera2D").position)))))
			print("")
			var top_left = map.world_to_map(position * get_node("../Camera2D").zoom + get_node("../Camera2D").position)
			var top_right = Vector2(top_left.x+1, top_left.y)
			var bottom_left = Vector2(top_left.x, top_left.y+1)
			var bottom_right = Vector2(top_left.x+1, top_left.y+1)
			map.set_cellv(top_left, map.tile_set.get_tiles_ids().size()-1)
			if building_size == 2:
				map.set_cellv(top_right, map.tile_set.get_tiles_ids().size()-1)
				map.set_cellv(bottom_left, map.tile_set.get_tiles_ids().size()-1)
				map.set_cellv(bottom_right, map.tile_set.get_tiles_ids().size()-1)
			

func set_building(building_name):
	placing = true
	print(building_name)
	match building_name:
		"house1":
			building_path = "res://Assets/Buildings/house_1.png"
			building_size = 2
			building_xp = 1
			building_cost = 1000
			building_upkeep = 200
			building_profit = 300
			building_type = "housing"
			building_pop_support = 10
		"house2":
			building_path = "res://Assets/Buildings/house_2.png"
			building_size = 2	
			building_xp = 2
			building_cost = 2500
			building_upkeep = 300
			building_profit = 500
			building_type = "housing"
			building_pop_support = 30
		"house3":
			building_path = "res://Assets/Buildings/house_3.png"
			building_size = 2
			building_xp = 3
			building_cost = 4000
			building_upkeep = 400
			building_profit = 650
			building_type = "housing"
			building_pop_support = 50
		"mall":
			building_path = "res://Assets/Buildings/Mall.png"
			building_size = 2
			building_xp = 1
			building_cost = 1500
			building_upkeep = 500
			building_profit = 650
			building_type = "commerce"
			building_pop_support = 100
		"restaurant":
			var restaurant_choice = randi() % 3
			if restaurant_choice == 0:
				building_path = "res://Assets/Buildings/Ramenshop.png"
			elif restaurant_choice == 0:
				building_path = "res://Assets/Buildings/Hotdogstand.png"
			else:
				building_path = "res://Assets/Buildings/Grocerystore.png"
			building_size = 2
			building_xp = 2
			building_cost = 1200
			building_upkeep = 500
			building_profit = 550
			building_type = "food"
			building_pop_support = 50
		"planetarium":
			building_path = "res://Assets/Buildings/Planetarium.png"
			building_size = 2
			building_xp = 3
			building_cost = 2500
			building_upkeep = 800
			building_profit = 900
			building_type = "entertainment"
			building_pop_support = 150
		"space_walk":
			building_path = "res://Assets/Buildings/MoonWalk.png"
			building_size = 2
			building_xp = 3
			building_cost = 4000
			building_upkeep = 1000
			building_profit = 1150
			building_type = "entertainment"
			building_pop_support = 100
		"bionics":
			building_path = "res://Assets/Buildings/Bionics.png"
			building_size = 2
			building_xp = 4
			building_cost = 5000
			building_upkeep = 700
			building_profit = 900
			building_type = "commerce"
			building_pop_support = 80
		"observatory":
			building_path = "res://Assets/Buildings/Observatory.png"
			building_size = 2
			building_xp = 2
			building_cost = 1500
			building_upkeep = 500
			building_profit = 550
			building_type = "research"
			building_pop_support = 20
		"biochem_lab":
			building_path = "res://Assets/Buildings/BioChemLab.png"
			building_size = 2
			building_xp = 4
			building_cost = 3000
			building_upkeep = 800
			building_profit = 850
			building_type = "research"
			building_pop_support = 40			
		"physics_lab":
			building_path = "res://Assets/Buildings/PhysicsLab.png"
			building_size = 2
			building_xp = 6
			building_cost = 5000
			building_upkeep = 900
			building_profit = 950
			building_type = "research"
			building_pop_support = 40
		"satellite":
			building_path = "res://Assets/Buildings/SatelliteLauncher.png"
			building_size = 2
			building_xp = 8
			building_cost = 10000
			building_upkeep = 1500
			building_profit = 1200
			building_type = "research"
			building_pop_support = 30
		"oxygen_tank":
			building_path = "res://Assets/Buildings/OxygenGeneratorSCALED.png"
			building_size = 1.3
			building_xp = 1
			building_cost = 500
			building_upkeep = 100
			building_profit = 80
			building_type = "utility"
			building_pop_support = 20
		"water_plant":
			building_path = "res://Assets/Buildings/WaterPlant.png"
			building_size = 2
			building_xp = 2
			building_cost = 800
			building_upkeep = 150
			building_profit = 140
			building_type = "utility"
			building_pop_support = 200
		"power_plant":
			building_path = "res://Assets/Buildings/PowerStation.png"
			building_size = 2
			building_xp = 3
			building_cost = 800
			building_upkeep = 250
			building_profit = 200
			building_type = "utility"
			building_pop_support = 300
		"greenhouse":
			building_path = "res://Assets/Buildings/greenhouse.png"
			building_size = 2
			building_xp = 4
			building_cost = 5000
			building_upkeep = 1000
			building_profit = 1100
			building_type = "food"
			building_pop_support = 200
		"fab_lab":
			building_path = "res://Assets/Buildings/FabLab.png"
			building_size = 2
			building_xp = 3
			building_cost = 6000
			building_upkeep = 1200
			building_profit = 1300
			building_type = "commerce"
			building_pop_support = 400

	$BuildingSprite.texture = load(building_path)
	#TODO: un-magic number this.
	var size = Vector2(224,114) * 0.5 * building_size #Tilemap cell size, with scale and building size included
	var scale_vec = size / $BuildingSprite.texture.get_size() #still a vector
	var scale = (scale_vec.y if scale_vec.x > scale_vec.y else scale_vec.x) - 0.02 #slightly smaller than the smaller scale value
	$BuildingSprite.scale.x = scale
	$BuildingSprite.scale.y = scale
	$BuildingSprite.self_modulate = Color(1,1,1,0.65)
