extends Node2D

var placing = false
var building_path = ""
var building_size = 1 # number of tiles (square) the building will occupy

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

			#I have tried this with much more and much less complex adjustments. Can't figure out what it should be.
			#I have basically tried all of the printed out coordinates above.
			var top_left = map.world_to_map(position * map.scale) 
			var top_right = Vector2(top_left.x+1, top_left.y)
			var bottom_left = Vector2(top_left.x, top_left.y+1)
			var bottom_right = Vector2(top_left.x+1, top_left.y+1)
			map.set_cellv(top_left, map.tile_set.get_tiles_ids().size()-1) #changing ground tiles, but offset!
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
		"house2":
			building_path = "res://Assets/Buildings/house_2.png"
			building_size = 2	
		"house3":
			building_path = "res://Assets/Buildings/house_3.png"
			building_size = 2
		"mall":
			building_path = "res://Assets/Buildings/Mall.png"
			building_size = 2
		"restaurant":
			var restaurant_choice = randi() % 3
			if restaurant_choice == 0:
				building_path = "res://Assets/Buildings/Ramenshop.png"
			elif restaurant_choice == 0:
				building_path = "res://Assets/Buildings/Hotdogstand.png"
			else:
				building_path = "res://Assets/Buildings/Grocerystore.png"
			building_size = 2
		"planetarium":
			building_path = "res://Assets/Buildings/Planetarium.png"
			building_size = 2
		"space_walk":
			building_path = "res://Assets/Buildings/MoonWalk.png"
			building_size = 2
		"bionics":
			building_path = "res://Assets/Buildings/Bionics.png"
			building_size = 2
		"observatory":
			building_path = "res://Assets/Buildings/Observatory.png"
			building_size = 2
		"biochem_lab":
			building_path = "res://Assets/Buildings/BioChemLab.png"
			building_size = 2
		"physics_lab":
			building_path = "res://Assets/Buildings/PhysicsLab.png"
			building_size = 2
		"satellite":
			building_path = "res://Assets/Buildings/SatelliteLauncher.png"
			building_size = 2
		"oxygen_tank":
			building_path = "res://Assets/Buildings/OxygenGeneratorSCALED.png"
			building_size = 1.3
		"water_plant":
			building_path = "res://Assets/Buildings/WaterPlant.png"
			building_size = 2
		"power_plant":
			building_path = "res://Assets/Buildings/PowerStation.png"
			building_size = 2
		"greenhouse":
			building_path = "res://Assets/Buildings/greenhouse.png"
			building_size = 2
		"fab_lab":
			building_path = "res://Assets/Buildings/FabLab.png"
			building_size = 2

	$BuildingSprite.texture = load(building_path)
	#TODO: un-magic number this.
	var size = Vector2(224,114) * 0.5 * building_size #Tilemap cell size, with scale and building size included
	var scale_vec = size / $BuildingSprite.texture.get_size() #still a vector
	var scale = (scale_vec.y if scale_vec.x > scale_vec.y else scale_vec.x) - 0.02 #slightly smaller than the smaller scale value
	$BuildingSprite.scale.x = scale
	$BuildingSprite.scale.y = scale
	$BuildingSprite.self_modulate = Color(1,1,1,0.65)
