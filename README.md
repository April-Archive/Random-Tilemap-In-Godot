# Random 2D Tilemap for Godot Game Engine


The world scene generates a random map from a 2D heightmap and a 3D array for tiles. Even though the map is 2D, it can stack multiple layers of tilemaps, hence the need for a 3D array. 

Each layer is stored in a seperate TileLayer scene. 

If a diffrent tileset is used the values for tile size in TileLayer may need to be changed, as well as Layer Offset in World scene. 

Layer Offset is how much the each TileLayer's y postion needs to be offset to maintain a 3D appearance.

