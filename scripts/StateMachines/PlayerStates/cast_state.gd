extends State

@onready var animated_sprite_2d = $"../../AnimatedSprite2D"
var dir := Vector2(0.0, 0.0)

func enter():
	player = get_parent().get_parent()
	state_machine = get_parent()
	player.velocity = Vector2.ZERO
	update_animation(dir)

# Change the states in physics update
#func physics_update(delta):
	#dir = Vector2(
		#Input.get_axis("left", "right"),
		#Input.get_axis("up", "down")
	#)
	

# Function to update the animation and sprite direction
func update_animation(direction: Vector2):
	var anim := "cast_down"

	if direction == Vector2.ZERO:
		animated_sprite_2d.play(anim)
		return

	direction = direction.normalized()


	if abs(direction.x) > 0.5 and abs(direction.y) > 0.5:
		if direction.y < 0:
			if direction.x > 0:
				anim = "cast_top_right"
			else:
				anim = "cast_top_left"
		else:
			if direction.x > 0:
				anim = "cast_down_right"
			else:
				anim = "cast_down_left"


	elif abs(direction.x) > abs(direction.y):
		if direction.x > 0:
			anim = "cast_right"
		else:
			anim = "cast_left"


	else:
		if direction.y < 0:
			anim = "cast_top"
		else:
			anim = "cast_down"

	animated_sprite_2d.play(anim)



func _on_animated_sprite_2d_animation_finished():
	print(animated_sprite_2d.animation)
	if animated_sprite_2d.animation.begins_with("cast") and state_machine.current_state.name == "CastState":
		$"../IdleState".dir = dir
		state_machine.change_state(state_machine.get_node("IdleState"))
