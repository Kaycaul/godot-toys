extends Node2D

var box_to_spawn : Resource = preload("uid://o30bocxuma8u")

func spawn_box() -> void:
	var new_box : RigidBody2D = box_to_spawn.instantiate()
	new_box.position = position
	add_sibling(new_box)
