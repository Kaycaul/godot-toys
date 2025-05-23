extends RigidBody2D

@export var move_force : float = 0.0
@onready var sprite : Sprite2D = $Sneakers

func _process(_delta: float) -> void:
	move(_delta)
	update_shader(_delta)

func move(delta : float) -> void:
	# get direction input vector
	var input : Vector2 = Vector2.ZERO
	input.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	input.y = Input.get_action_strength("move_back") - Input.get_action_strength("move_forward")
	input = input.normalized()
	# apply impulse in that direction
	apply_impulse(input * move_force * delta * 144)

func update_shader(_delta : float) -> void:
	sprite.material.set_shader_parameter("wave_offset", position * 0.1)

func set_redness_amount(redness : float) -> void:
	sprite.material.set_shader_parameter("red_amount", redness)

func become_not_red() -> void:
	set_redness_amount(0.0)
