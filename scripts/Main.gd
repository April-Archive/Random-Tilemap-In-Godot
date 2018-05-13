extends Node2D

#func _ready():
#_tileset = get_node("World")

func _input(event):
   # Mouse in viewport coordinates
   if event is InputEventMouseButton:
       print("Mouse Click/Unclick at: ", event.position)
   elif event is InputEventMouseMotion:
       print("Mouse Motion at: ", event.position)

   # Print the size of the viewport
   print("Viewport Resolution is: ", get_viewport_rect().size)