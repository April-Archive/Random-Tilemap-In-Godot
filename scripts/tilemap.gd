extends TileMap

var map = preload("res://libs/2dAs1dMap.gd")

var layout setget setLayout, getLayout

func _ready():
	pass
				
func getLayout():
	return layout

# Layout is represented as a 2d array mapped to a 1d array
func setLayout(new_layout):
	# Check that new layout is an array
	#if new_layout extends TwoToOneMap :
		#return false
	layout = new_layout
	renderLayout()
	
func renderLayout():
	for x in range(0, layout.width):
		for y in range(0, layout.height):
			set_cell(x, y, layout.get(x, y))


#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

