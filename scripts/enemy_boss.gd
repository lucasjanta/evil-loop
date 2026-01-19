extends CharacterBody2D

@export var walk_speed : float = 50.0
@export var chase_speed : float = 75.0
@export var player_ref : CharacterBody2D
var on_range := false
var on_atk_range := false
var can_attack := false
var on_dash_atk_range := false
var can_dash := false
var atk_timer := 2.0
var dash_atk_timer := 4.0

var hit_dmg := 0.0

func _physics_process(delta):
	if atk_timer > 0.0 and !can_attack:
		atk_timer -= delta
	else:
		can_attack = true
		atk_timer = randf_range(2.0, 4.0)
		
	if dash_atk_timer > 0.0 and !can_dash:
		dash_atk_timer -= delta
	else:
		can_dash = true
		dash_atk_timer = randf_range(3.0, 6.0)
		
	if global_position.x < 16:
		global_position.x = 16
	elif global_position.x > 312:
		global_position.x = 312
	
	if global_position.y > 176:
		global_position.y = 176
	elif global_position.y < 25:
		global_position.y = 25

func _on_detection_area_body_entered(body):
	if body is Player:
		on_range = true


func _on_detection_area_body_exited(body):
	if body is Player:
		on_range = false


func _on_mellee_attack_area_body_entered(body):
	if body is Player:
		on_atk_range = true


func _on_mellee_attack_area_body_exited(body):
	if body is Player:
		on_atk_range = false

func _on_dash_attack_area_body_entered(body):
	if body is Player:
		on_dash_atk_range = true


func _on_dash_attack_area_body_exited(body):
	if body is Player:
		on_dash_atk_range = false


func _on_base_attack_hit_area_area_entered(area):
	if area.name == "hurtArea":
		print("acertou o player")
		area.get_parent().take_dmg(hit_dmg)
