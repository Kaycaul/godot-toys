extends RigidBody2D
class_name WeekndPlayer

@export var jump_force : float
@export var move_force : float

func _process(delta: float) -> void:
	# move sideways
	var input : Vector2 = Vector2.ZERO
	input.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	apply_impulse(input * move_force * delta)
	# reduce friction only while moving
	if input.x > 0 or input.x < 0:
		physics_material_override.friction = 0.05
	else:
		physics_material_override.friction = 0.70
	# jump
	if Input.is_action_just_pressed("jump"):
		apply_central_impulse(Vector2.UP * jump_force)
