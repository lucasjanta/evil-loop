extends State

@onready var animated_sprite_2d = $"../../AnimatedSprite2D"
@onready var hit_area = $"../../hitArea"
@onready var hit_area_collision = $"../../hitArea/CollisionShape2D"

var dir := Vector2(0.0, 0.0)

# Function to initialize the variables correctly
func enter():
	player = get_parent().get_parent()
	state_machine = get_parent()
	hit_area_collision.disabled = false
	player.velocity = Vector2.ZERO
	update_animation(dir)
	

func physics_update(delta):
	player.move_and_slide()
	#if Input.is_action_just_pressed("mouse_cast"):
		#$"../CastState".dir = last_dir
		#state_machine.change_state(state_machine.get_node("CastState"))

# Function to update the animation and sprite direction
func update_animation(direction: Vector2):
	var anim := "swordAttack_down"

	if direction == Vector2.ZERO:
		animated_sprite_2d.play(anim)
		hit_area.rotation_degrees = 90
		return

	direction = direction.normalized()

	# Diagonais
	if abs(direction.x) > 0.5 and abs(direction.y) > 0.5:
		if direction.y < 0:
			if direction.x > 0:
				anim = "swordAttack_top_right"
				hit_area.rotation_degrees = -45
			else:
				anim = "swordAttack_top_left"
				hit_area.rotation_degrees = -135
		else:
			if direction.x > 0:
				anim = "swordAttack_down_right"
				hit_area.rotation_degrees = 45
			else:
				anim = "swordAttack_down_left"
				hit_area.rotation_degrees = 135

	# Horizontal
	elif abs(direction.x) > abs(direction.y):
		if direction.x > 0:
			anim = "swordAttack_right"
			hit_area.rotation_degrees = 0
		else:
			anim = "swordAttack_left"
			hit_area.rotation_degrees = 180

	# Vertical
	else:
		if direction.y < 0:
			anim = "swordAttack_top"
			hit_area.rotation_degrees = 270
		else:
			anim = "swordAttack_down"
			hit_area.rotation_degrees = 90

	animated_sprite_2d.play(anim)


func _on_animated_sprite_2d_animation_finished():
	if animated_sprite_2d.animation.begins_with("swordAttack") and state_machine.current_state.name == "SwordAttack1State":
		$"../IdleState".dir = dir
		state_machine.change_state(state_machine.get_node("IdleState"))

func exit():
	hit_area_collision.disabled = true
