extends State

@onready var animated_sprite_2d = $"../../AnimatedSprite2D"
var dir := Vector2(0.0, 0.0)
var last_dir : Vector2

@export var change_side_timer := 2.5

# Function to initialize the variables correctly
func enter():
	player = get_parent().get_parent()
	state_machine = get_parent()
	random_side()
	update_animation(dir)
	last_dir = dir
	

func physics_update(delta):
	change_side_timer -= delta
	if change_side_timer <= 0.0:
		random_side()
	
	if player.global_position.x > 300.0 or player.global_position.x < 16.0:
		random_side()
	if player.global_position.y > 176.0 or player.global_position.y < 25.0:
		random_side()
	player.velocity = player.walk_speed * dir
	player.move_and_slide()
	
	#if dir != Vector2.ZERO:
		#state_machine.change_state(state_machine.get_node("WalkState"))

# Function to update the animation and sprite direction
func update_animation(direction: Vector2):
	var anim := "Walk"

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
	dir = Vector2(randf_range(-1,1), randf_range(-1,1))
	update_animation(dir)
	change_side_timer = 2.5
