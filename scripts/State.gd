extends Node

var player

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

# Handle any transitions into this state. 
func enter(player):
    self.player = player
	
# Exit the current state, enter a new one.
func set_state(state):
    player.state.exit()
    player.state = state
    state.enter(player)

# Handle input events.
func _input(event):
    pass

# Handle exit events.
func exit():
    pass