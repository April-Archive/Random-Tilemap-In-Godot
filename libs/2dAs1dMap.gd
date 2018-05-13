
class TwoToOneMap: 
	var width
	var height
	var length
	var _map
	
	func _init(width, height, default_value = null):
		self.width = width
		self.height = height
		self.length = width*height
		_map = []
		
		for x in range(0, width*height):
			_map.append(default_value)
	
	func set(x, y, value):
		if(x < 0 or y < 0 or x > width or y > height):
			return ERR_INVALID_PARAMETER
		_map[get1dIndex(x, y)] = value
	
	func get(x, y): 
		return _map[get1dIndex(x, y)]
	
	# function based on map objects width
	func get1dIndex(row, col):
		return width * row + col 	
		
	func toString():
		var mapAsString = ""
		for y in range(0, height):
			for x in range(0, width):
				var comma = "," if x != width-1 else ""
				mapAsString += str(_map[get1dIndex(x, y)]) + comma + " "
			mapAsString += "\n"
		return mapAsString
		
# Static function
func get1dIndec(row, col, width): 
	return width * row + col 	