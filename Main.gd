extends Node2D

onready var map = $TileMap
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	generate_map()
	randomize()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func generate_map():
	var numTiles = map.tile_set.get_tiles_ids().size()
	for x in range(-20,20):
		for y in range (-20,20):
			var clone_chance = 0.0
			var clone_tile_candidates = []
			for i in range(x-1, x+2):
				for j in range(y-1, y+2):
					if(i != x && j != y): #if we're not on the tile we're generating for 
						var neighbor_cell = map.get_cell(i,j)
						if(neighbor_cell != -1 && neighbor_cell != 6 && neighbor_cell != 7):
							clone_chance += 0.1
							clone_tile_candidates.append(neighbor_cell)
			if randf() < clone_chance:
				map.set_cellv(Vector2(x,y), clone_tile_candidates[randi() % clone_tile_candidates.size()])
			else:
				map.set_cellv(Vector2(x,y), randi() % numTiles)
				
