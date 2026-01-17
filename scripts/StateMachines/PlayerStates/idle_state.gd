extends State

@onready var animated_sprite_2d = $"../../AnimatedSprite2D"
var dir := Vector2(0.0, 0.0)

# Function to initialize the variables correctly
func enter():
	player = get_parent().get_parent()
	state_machine = get_parent()
	player.velocity = Vector2.ZERO
	update_animation(dir)
# Update the animation
#func update(delta):
	#

# Change the states in physics update
func physics_update(delta):
	dir = Vector2(
		Input.get_axis("left", "right"),
		Input.get_axis("up", "down")
	)

	if dir != Vector2.ZERO:
		state_machine.change_state(state_machine.get_node("WalkState"))
	

# Function to update the animation and sprite direction
func update_animation(direction: Vector2):
	var anim := "idle_down"

	if direction == Vector2.ZERO:
		animated_sprite_2d.play(anim)
		return

	direction = direction.normalized()

	# Diagonais
	if abs(direction.x) > 0.5 and abs(direction.y) > 0.5:
		if direction.y < 0:
			if direction.x > 0:
				anim = "idle_top_right"
			else:
				anim = "idle_top_left"
		else:
			if direction.x > 0:
				anim = "idle_down_right"
			else:
				anim = "idle_down_left"

	# Horizontal
	elif abs(direction.x) > abs(direction.y):
		if direction.x > 0:
			anim = "idle_right"
		else:
			anim = "idle_left"

	# Vertical
	else:
		if direction.y < 0:
			anim = "idle_top"
		else:
			anim = "idle_down"

	animated_sprite_2d.play(anim)
