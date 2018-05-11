extends Node2D

export (int) var num_of_layers
export (int) var layer_offset
export (int) var layer_height
export (int) var layer_width

var map = []

var tiles = {"blank": 0, "dirt": 1, "emerald": 2, "grass": 3, "ruby": 4, "sapphire": 5, "water": 6, "stone": 7}
var basic_tiles = ["grass", "dirt", "water", "stone"]
var rare_tiles = ["emerald", "ruby", "sapphire"]

func _ready():
	randomize()
	
	# Generate map and render layers
	genMap()
	for i in range(0, num_of_layers):
		renderLayer(i)
	

func renderLayer(layer):
	var scene = load("res://TileLayer.tscn")
	var scene_instance = scene.instance()
	var instance_name = "TileLayer_"+str(layer)
	
	scene_instance.set_name(instance_name)
	add_child(scene_instance)
	scene_instance.setLayout(map[layer], layer_width)
	#offset height for each layer
	get_node(instance_name).position = Vector2(0, (num_of_layers - layer -1) * layer_offset)
	
func genMap():
	for i in range(0, num_of_layers):
		map.append(genLayer(i))
		
		
func genLayer(layer):
	var layer_layout = []
	
	for i in range(0, layer_width*layer_height):
		layer_layout.append(-1)
	
	for x in range(0, layer_width):
		for y in range(0, layer_height):
			layer_layout[get1dIndex(x, y)] = genTile(x, y, layer)
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
	
func validateTile(row, col):
	assert(!(row > layer_width or row < 0 or col > layer_height or col < 0))
		#("invalid row or column value. Row: " + str(row) + ", Column: " + str(col))
		
func get1dIndex(row, col):
	return layer_width * row + col 	
	
## force empty
## Force non empty
## somtimes empty
## only empty or water ontop of water