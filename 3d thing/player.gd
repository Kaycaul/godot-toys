extends RigidBody3D

@export var movement_force : float

func _process(delta: float) -> void:
	var input : Vector3 = Vector3.ZERO
	input.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	input.z = Input.get_action_strength("move_back") - Input.get_action_strength("move_forward")
	apply_impulse(input * movement_force * delta)
