extends State

@onready var animated_sprite_2d = $"../../AnimatedSprite2D"
var dir := Vector2(0.0, 0.0)
var last_dir : Vector2


# Function to initialize the variables correctly
func enter():
	player = get_parent().get_parent()
	state_machine = get_parent()
	dir = (player.player_ref.global_position - player.global_position).normalized()
	update_animation(dir)
	last_dir = dir
	

func physics_update(delta):
	dir = (player.player_ref.global_position - player.global_position).normalized()
	update_animation(dir)
	player.velocity = player.chase_speed * dir
	player.move_and_slide()
	
	if player.on_atk_range and player.can_attack:
		state_machine.change_state(state_machine.get_node("MelleeAttackState"))

	if player.on_dash_atk_range and player.can_dash:
		state_machine.change_state(state_machine.get_node("DashAttackState"))
		
# Function to update the animation and sprite direction
func update_animation(direction: Vector2):
	var anim := "Run2"

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
