extends State

@onready var animated_sprite_2d = $"../../AnimatedSprite2D"
var dir := Vector2(0.0, 0.0)
var last_dir : Vector2
var side_changes := 0

@export var change_side_timer := 2.5

# Function to initialize the variables correctly
func enter():
	player = get_parent().get_parent()
	state_machine = get_parent()
	player.velocity = Vector2.ZERO
	update_animation(dir)
	last_dir = dir
	side_changes = 0
	

func physics_update(delta):
	change_side_timer -= delta
	if change_side_timer <= 0.0:
		random_side()
	
	
	#if dir != Vector2.ZERO:
		#state_machine.change_state(state_machine.get_node("WalkState"))

# Function to update the animation and sprite direction
func update_animation(direction: Vector2):
	var anim := "Idle"

	if direction == Vector2.ZERO:
		animated_sprite_2d.play(anim)
		return

	direction = direction.normalized()

	if direction.x > 0:
		animated_sprite_2d.flip_h = false
		animated_sprite_2d.offset.x = 32
	else:
		animated_sprite_2d.flip_h = true
		animated_sprite_2d.offset.x = -32

	animated_sprite_2d.play(anim)

func random_side():
	dir.x = [-1,1].pick_random()
	update_animation(dir)
	change_side_timer = 2.5
	side_changes += 1
	if side_changes >= 2:
		state_machine.change_state(state_machine.get_node("WalkState"))
