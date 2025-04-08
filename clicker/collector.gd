extends Area2D

signal thing_collected

func _on_body_entered(body: Node2D) -> void:
	var wega = body as Wega
	if not wega: return
	wega.queue_free()
	thing_collected.emit()
