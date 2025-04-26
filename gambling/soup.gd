extends Area2D

@export var explosion_particle_count : int = 30
@export var explosion_force : float = 1000.0
@export var explosion_randomness : float = 0.0 # what % +/- will be added
@export var explosion_particle_lifetime : float = 1.0
@export var lifetime_randomness : float = 0.0

var soup_particle : Resource = preload("uid://03wpfuvr77js")

func spawn_explosion() -> void:
	for i in range(explosion_particle_count):
		var new_soup_particle : SoupParticle = soup_particle.instantiate()
		new_soup_particle.position = position
		# pick a random direction to rotate it towards, then push it
		var random_percentage : float = randf_range(-explosion_randomness, explosion_randomness)
		var random_force : float = explosion_force * (1 + random_percentage)
		var random_lifetime : float = explosion_particle_lifetime * (1 + random_percentage)
		var random_angle : float = randf_range(0, 2 * PI)
		var random_direction : Vector2 = Vector2(cos(random_angle), sin(random_angle))
		new_soup_particle.rotation = random_angle
		new_soup_particle.apply_central_impulse(random_direction * random_force)
		new_soup_particle.set_lifetime(random_lifetime)
		# add to tree
		call_deferred("add_sibling", new_soup_particle)
