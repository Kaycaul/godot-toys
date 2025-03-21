extends Node2D

@onready var explosion : Area2D = %Explosion

func _process(delta: float) -> void:
	# move
	position = get_global_mouse_position()
	rotation += 5.0 * delta
	# explode
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		var collided_things = explosion.get_overlapping_bodies()
		for thing in collided_things:
			var dist : Vector2 = thing.position - position
			var force : float = dist.length()
			var dir : Vector2 = dist.normalized()
			#force = 1 / force
			
			thing.apply_impulse(dir * force)
