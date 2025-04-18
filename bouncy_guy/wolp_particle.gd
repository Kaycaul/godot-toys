extends RigidBody2D

@export var gravity_force : float = 0.0

@onready var gravity : Area2D = %gravity

func _physics_process(_delta: float) -> void:
	var collided_things = gravity.get_overlapping_bodies()
	for thing : RigidBody2D in collided_things:
		var dist : Vector2 = thing.position - position
		var dir : Vector2 = dist.normalized()
		var radius : float = %gravityCollider.shape.radius
		var dist_percent = dist.length() / radius
		dist_percent = 1 - clampf(dist_percent, 0.0, 1.0)
		thing.apply_force(dir * -gravity_force * dist_percent)
