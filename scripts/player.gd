extends CharacterBody2D
class_name Player

@export var speed : float = 75.0
@export var max_hp := 100.0
var hp : float = 100.0

func _ready():
	hp = max_hp

func take_dmg(damage):
	hp -= damage
	print("player took ", damage, " of damage")
	if hp <= 0:
		print("DIE")
