extends Node
#Variables to deal with the states
@export var initial_state_path: NodePath
var current_state : State

# Set the first state and start it
func _ready():
	current_state = get_node(initial_state_path)
	current_state.enter()
	
# Calls the functions in states related to input
func _unhandled_input(event):
	if current_state:
		current_state.handle_input(event)
		
# Calls the functions in states related to updates
func _process(delta):
	if current_state:
		current_state.update(delta)

# Calls the functions in states related to physic updates
func _physics_process(delta):
	if current_state:
		current_state.physics_update(delta)

# Function to change state if the new state is different from the current one, calling exit() and enter() functions in the correspondent states
func change_state(new_state : Node):
	if current_state == new_state:
		return
	current_state.exit()
	current_state = new_state
	current_state.enter()
