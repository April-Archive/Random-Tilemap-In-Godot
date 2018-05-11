extends TileMap

export (int) var NUM_OF_TILES

var xCells
var yCells

var layout setget setLayout, getLayout

var tiles = ["grass", "dirt", "water", "emerald", "ruby", "sapphire", "stone"]
var basic_tiles = ["grass", "dirt", "water", "stone"]
var rare_tiles = ["emerald", "ruby", "sapphire"]

var width

func _ready():
	randomize()
	
	width = 5
	

	"""
	var height = get_viewport_rect().size.y
	var width = get_viewport_rect().size.x
	xCells = width/cell_size.x
	yCells = height/cell_size.y
	for x in range(0, xCells):
		for y in range(0, yCells):
			# Allow for empty cell
			var rand = randi()%(len(basic_tiles)+1)-1
			var index = -1 if rand == -1 else tile_set.find_tile_by_name(basic_tiles[rand])
			set_cell(x, y, index)
		"""
			
func getLayout():
	return layout

# Layout is represented as a 2d array mapped to a 1d array
func setLayout(new_layout, new_width):
	# Check that new layout is an array
	if not typeof(new_layout) == 19:
		return false
	layout = new_layout
	width = new_width
	renderLayout()
	
func renderLayout():
	for x in range(0, width):
		for y in range(0, len(layout)/width):
			set_cell(x, y, layout[get1dIndex(x, y)])

func get1dIndex(row, col):
	return width * row + col 
 

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

