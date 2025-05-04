extends RigidBody2D
class_name SoupParticle

@onready var timer : Timer = %Timer

var lifetime : float = 1.0

func _ready() -> void:
	update_lifetime()

func set_lifetime(new_lifetime : float) -> void:
	lifetime = new_lifetime
	update_lifetime()

func update_lifetime() -> void:
	if not is_node_ready(): return
	timer.start(lifetime)
