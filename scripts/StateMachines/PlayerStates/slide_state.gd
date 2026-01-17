extends State

@onready var animated_sprite_2d = $"../../AnimatedSprite2D"
@onready var hurt_area_collision = $"../../hurtArea/CollisionShape2D"

var dir := Vector2(0.0, 0.0)

# Function to initialize the variables correctly
func enter():
	player = get_parent().get_parent()
	state_machine = get_parent()
	hurt_area_collision.disabled = true
	#player.velocity = Vector2.ZERO
	update_animation(dir)
	

func physics_update(delta):
	player.velocity = (player.speed * 2) * dir
	player.move_and_slide()
	#if Input.is_action_just_pressed("mouse_cast"):
		#$"../CastState".dir = last_dir
		#state_machine.change_state(state_machine.get_node("CastState"))

# Function to update the animation and sprite direction
func update_animation(direction: Vector2):
	var anim := "slide_start_down"

	if direction == Vector2.ZERO:
		animated_sprite_2d.play(anim)
		return

	direction = direction.normalized()

	# Diagonais
	if abs(direction.x) > 0.5 and abs(direction.y) > 0.5:
		if direction.y < 0:
			if direction.x > 0:
				anim = "slide_start_top_right"
			else:
				anim = "slide_start_top_left"
		else:
			if direction.x > 0:
				anim = "slide_start_down_right"
			else:
				anim = "slide_start_down_left"

	# Horizontal
	elif abs(direction.x) > abs(direction.y):
		if direction.x > 0:
			anim = "slide_start_right"
		else:
			anim = "slide_start_left"

	# Vertical
	else:
		if direction.y < 0:
			anim = "slide_start_top"
		else:
			anim = "slide_start_down"

	animated_sprite_2d.play(anim)



func _on_animated_sprite_2d_animation_finished():
	if animated_sprite_2d.animation.begins_with("slide_start") and state_machine.current_state.name == "SlideState":
		$"../IdleState".dir = dir
		state_machine.change_state(state_machine.get_node("IdleState"))

func exit():
	hurt_area_collision.disabled = false
