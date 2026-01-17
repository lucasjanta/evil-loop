extends Node
class_name State

# Set the base variables
var player
var state_machine

# Set the base functions for the states
func enter(): pass
func exit(): pass
func handle_input(event): pass
func update(delta): pass
func physics_update(delta): pass
