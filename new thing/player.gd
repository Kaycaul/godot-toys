extends RigidBody2D

@export var jump_force : float

func _process(_delta: float) -> void:
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		jump()

func jump() -> void:
	var mouse_position : Vector2 = get_global_mouse_position()
	var dir : Vector2 = mouse_position - position
	apply_central_impulse(dir.normalized() * jump_force)
