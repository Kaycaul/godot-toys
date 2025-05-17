extends Area2D

signal thing_collected

@onready var scream_player : AudioStreamPlayer = %"Scream Player"

func _on_body_entered(body: Node2D) -> void:
	var wega = body as Wega
	if not wega: return
	wega.on_collect()
	thing_collected.emit()

func play_scream_sound() -> void:
	scream_player.pitch_scale = randf_range(0.95, 1.05)
	scream_player.play()
