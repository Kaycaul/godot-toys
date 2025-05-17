extends RigidBody2D
class_name Wega

var explosion_to_spawn : Resource = preload("uid://bjcy3oh68p45n")

func on_collect() -> void:
	var new_explosion : WegaExplosion = explosion_to_spawn.instantiate()
	new_explosion.position = position
	new_explosion.explode()
	add_sibling(new_explosion)
	queue_free()
