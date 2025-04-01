extends RigidBody2D

@export var min_bonk_volume : float = 0.0
@export var max_bonk_volume : float = 0.0

@onready var bonk: AudioStreamPlayer2D = %bonk

func _on_body_entered(_body: Node) -> void:
	var t = linear_velocity.length() / 200.0
	t = clampf(t, 0.0, 1.0)
	var db = lerpf(min_bonk_volume, max_bonk_volume, t)
	bonk.volume_db = db
	bonk.play()
