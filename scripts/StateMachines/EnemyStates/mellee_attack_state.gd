extends State

@onready var animated_sprite_2d = $"../../AnimatedSprite2D"
@onready var base_hit_collision = $"../../AttackAreas/BaseAttackHitArea/BaseHitCollision"
@onready var attack_areas = $"../../AttackAreas"

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
	player.move_and_slide()
	match animated_sprite_2d.frame:
		2:
			player.hit_dmg = 30.0
		3:
			base_hit_collision.disabled = false
		5:
			base_hit_collision.disabled = true
		6:
			player.hit_dmg = 20.0
		7:
			base_hit_collision.disabled = false
		10:
			base_hit_collision.disabled = true
	#if dir != Vector2.ZERO:
		#state_machine.change_state(state_machine.get_node("WalkState"))

# Function to update the animation and sprite direction
func update_animation(direction: Vector2):
	var anim := "Attack"

	if direction == Vector2.ZERO:
		animated_sprite_2d.play(anim)
		return

	direction = direction.normalized()

	if direction.x > 0:
		attack_areas.rotation_degrees = 0
		animated_sprite_2d.flip_h = false
		animated_sprite_2d.offset.x = 32
	else:
		attack_areas.rotation_degrees = 180
		animated_sprite_2d.flip_h = true
		animated_sprite_2d.offset.x = -32

	animated_sprite_2d.play(anim)


func _on_animated_sprite_2d_animation_finished():
	if animated_sprite_2d.animation == "Attack" and state_machine.current_state.name == "MelleeAttackState":
		player.can_attack = false
		state_machine.change_state(state_machine.get_node("IdleState"))
