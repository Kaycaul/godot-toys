extends Node2D

@export var max_speed : float = 0.0
@export var force : float = 0.0

@onready var lifter : Area2D = %Lifter

func _process(delta: float) -> void:
	# get all colliding bodies
	var bodies : Array[Node2D] = lifter.get_overlapping_bodies()
	for body in bodies:
		# check each one for max speed
		var rb : RigidBody2D = body as RigidBody2D
		if not rb: continue
		if rb.linear_velocity.y <= -max_speed: continue
		# apply acceleration
		rb.apply_impulse(Vector2(0.0, -force * delta))
