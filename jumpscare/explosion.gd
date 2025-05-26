extends Node2D
class_name JumpscareExplosion

@onready var gpu_particles_2d: GPUParticles2D = %GPUParticles2D

func _ready() -> void:
	gpu_particles_2d.finished.connect(on_explosion_finished)
	gpu_particles_2d.one_shot = true
	gpu_particles_2d.emitting = true

func on_explosion_finished() -> void:
	queue_free()
