extends Node2D
class_name WegaExplosion

func explode() -> void:
	$GPUParticles2D.emitting = true
	await $GPUParticles2D.finished
	queue_free()
