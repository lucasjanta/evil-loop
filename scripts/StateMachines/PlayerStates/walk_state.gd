extends State

@onready var animated_sprite_2d: AnimatedSprite2D = $"../../AnimatedSprite2D"

var dir: Vector2 = Vector2.ZERO
var next_dir := Vector2.DOWN

func enter():
	player = get_parent().get_parent()
	state_machine = get_parent()

func physics_update(delta):
	
	dir = Vector2(
		Input.get_axis("left", "right"),
		Input.get_axis("up", "down")
	)
	
	if dir == Vector2.ZERO:
		player.velocity = Vector2.ZERO
		state_machine.change_state(state_machine.get_node("IdleState"))
		return
	
	if Input.is_action_just_pressed("mouse_cast"):
		$"../CastState".dir = dir
		state_machine.change_state(state_machine.get_node("CastState"))
		return
		
	if Input.is_action_just_pressed("slide"):
		$"../SlideState".dir = dir
		state_machine.change_state(state_machine.get_node("SlideState"))
		return
		
	if Input.is_action_just_pressed("basic_attack"):
		$"../SwordAttack1State".dir = dir
		state_machine.change_state(state_machine.get_node("SwordAttack1State"))
		return

	dir = dir.normalized()
	
	player.velocity = dir * player.speed
	player.move_and_slide()
	update_animation(dir)
	
	if dir != Vector2.ZERO:
		next_dir = dir

func update_animation(direction: Vector2):
	var anim := "walk_down"

	# Diagonais
	if abs(direction.x) > 0.5 and abs(direction.y) > 0.5:
		if direction.y < 0:
			if direction.x > 0:
				anim = "walk_top_right"
			else:
				anim = "walk_top_left"
		else:
			if direction.x > 0:
				anim = "walk_down_right"
			else:
				anim = "walk_down_left"

	# Horizontal
	elif abs(direction.x) > abs(direction.y):
		if direction.x > 0:
			anim = "walk_right"
		else:
			anim = "walk_left"

	# Vertical
	else:
		if direction.y < 0:
			anim = "walk_top"
		else:
			anim = "walk_down"

	animated_sprite_2d.play(anim)

func exit():
	$"../IdleState".dir = next_dir
	print("go to idle")
