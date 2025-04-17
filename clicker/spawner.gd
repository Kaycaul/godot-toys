extends Node2D

var box_to_spawn : Resource = preload("uid://o30bocxuma8u")

signal box_spawned(new_box : RigidBody2D)

func spawn_box() -> void:
	var new_box : RigidBody2D = box_to_spawn.instantiate()
	new_box.position = position
	add_sibling(new_box)
	box_spawned.emit(new_box)
