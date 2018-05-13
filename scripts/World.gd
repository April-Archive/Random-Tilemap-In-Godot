extends Node2D

export (int) var map_depth
export (int) var layer_offset
export (int) var map_height
export (int) var map_width

var perlin = preload("res://libs/SoftNoise.gd")
var twoD_array = preload("res://libs/2dAs1dMap.gd")

var map = []
var height_noise_map
var terrian_noise_map

var tiles = {"blank": 0, "dirt": 1, "emerald": 2, "grass": 3, "ruby": 4, "sapphire": 5, "water": 6, "stone": 7}
var basic_tiles = ["grass", "dirt", "water", "stone"]
var rare_tiles = ["emerald", "ruby", "sapphire"]

func _ready():
	#Random
	randomize()
	height_noise_map = perlin.SoftNoise.new()
	terrian_noise_map = perlin.SoftNoise.new()
	#map = twoD_array.TwoToOneMap.new(layer_width, map_height)
	
	# Generate map and render layers
	genMap()
	for i in range(0, map_depth):
		renderLayer(i)
	
# Add add map layers to scene tree
func renderLayer(layer):
	var scene = load("res://scenes/TileLayer.tscn")
	var scene_instance = scene.instance()
	var instance_name = "TileLayer_"+str(layer)
	
	scene_instance.set_name(instance_name)
	add_child(scene_instance)
	scene_instance.setLayout(map[layer])
	#offset height for each layer
	get_node(instance_name).position = Vector2(0, (map_depth - layer -1) * layer_offset)
	
# Generate Tiles and height map
func genMap():
	var height_map = twoD_array.TwoToOneMap.new(map_width, map_height, 1)
	var terrian_map = [] 
	
	for z in range(0, map_depth):
		terrian_map.append(twoD_array.TwoToOneMap.new(map_width, map_height))
		for x in range(0, map_width):
			for y in range(0, map_height): 
				if z == 0:
					height_map.set(x, y, getPerlinValue(x, y, 1, map_depth, height_noise_map))
				terrian_map[z].set(x, y, getPerlinValue3d(x, y, z, 0, len(basic_tiles)-1, terrian_noise_map))
			
	computeMap(height_map, terrian_map)

# Add tiles to map
func computeMap(height_map, terrian_map):
	for z in range(0, map_depth):
		var layer_layout = twoD_array.TwoToOneMap.new(map_width, map_height, -1)		
		map.append(layer_layout)
	for x in range(0, map_width):
		for y in range(0, map_height):
			var height = height_map.get(x, y)
			while(height > 0):
				map[height-1].set(x, y, tiles[(basic_tiles[terrian_map[height-1].get(x, y)])])
				height-= 1

# Fit perlin values into a range
func getPerlinValue(x, y, _min, _max, noise_map):
	return abs(floor(noise_map.openSimplex2D(x, y) * (_max - _min))) + _min

func getPerlinValue3d(x, y, z, _min, _max, noise_map):
	return abs(floor(noise_map.openSimplex3D(x, y, z) * (_max - _min))) + _min
		
"""
func genLayer(layer):
	# create a 2d map initlized with a default value of -1 (empty cell)
	var layer_layout = twoD_array.TwoToOneMap.new(map_width, map_height, -1)
		
	for x in range(0, map_width):
		for y in range(0, map_height):
			layer_layout.set(x, y, genTile(x, y, layer))
	return layer_layout
	
	
func genTile(x, y, layer):
	var tileBelow = getTileBelow(x, y, layer)
	# Force empty cell if tile below is empty
	var index = -1
	# Force nonempty cell if tile is on layer 0
	var _range = 0 if layer == 0 else 1
	if !tileBelow or tileBelow >= 0:
		var rand = randi()%(len(basic_tiles)+_range) - _range
		index = -1 if rand == -1 else tiles[(basic_tiles[rand])]
	return index
	
	
func getTileBelow(row, col, layer):
	validateTile(row, col)
	# No layer is below
	if layer <= 0:
		return false
	return map[layer-1][get1dIndex(row, col)]

"""
	
func validateTile(row, col):
	assert(!(row > map_width or row < 0 or col > map_height or col < 0))
		#("invalid row or column value. Row: " + str(row) + ", Column: " + str(col))
		

	
