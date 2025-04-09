extends Node2D

@export var reverse := false
@export var max_speed : float = 0.0
@export var force : float = 0.0

@onready var pusher : Area2D = %Pusher

func _process(delta: float) -> void:
	# get all colliding bodies
	var bodies : Array[Node2D] = pusher.get_overlapping_bodies()
	for body in bodies:
		# check each one for max speed
		var rb : RigidBody2D = body as RigidBody2D
		if not rb: continue
		if rb.linear_velocity.x >= max_speed and not reverse: continue
		if rb.linear_velocity.x <= -max_speed and reverse: continue
		# apply acceleration
		var dir := -1 if reverse else 1
		rb.apply_impulse(Vector2(force * delta * dir, 0.0))

func set_force(new_force : int) -> void:
	force = new_force
