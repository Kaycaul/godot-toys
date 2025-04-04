extends RigidBody2D

@export var move_force : float = 0.0

var wolp_particle : Resource = preload("uid://cl35vab8dlcdw")

func _process(_delta: float) -> void:
	move()
	explode()

func explode() -> void:
	if Input.is_physical_key_pressed(KEY_SPACE):
		var new_guy = wolp_particle.instantiate()

func move() -> void:
	# get direction input vector
	var input : Vector2 = Vector2.ZERO
	input.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	input.y = Input.get_action_strength("move_back") - Input.get_action_strength("move_forward")
	input = input.normalized()
	# apply impulse in that direction
	apply_impulse(input * move_force)
