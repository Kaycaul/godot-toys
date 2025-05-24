extends Node2D
class_name Gun

@export var reload_speed := 0.7

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var shot_explosion: AudioStreamPlayer = $ShotExplosion
@onready var shell_bounce: AudioStreamPlayer = $ShellBounce

var reloading := false
var speed_scale := 1.0

func _ready() -> void:
	update_reload_speed()
	animation_player.animation_finished.connect(reload.unbind(1))

func update_reload_speed() -> void:
	var animation_length := animation_player.get_animation("shoot_reload").length
	update_speed_scale(reload_speed / animation_length)

func is_reloading() -> bool:
	return reloading

func reload() -> void:
	reloading = false

func shoot() -> void:
	# dont shoot unless actually able to
	if is_reloading(): return
	reloading = true
	# play the animation
	animation_player.play("shoot_reload")
	# randomize the sounds a little
	var random_factor := randf_range(0.95, 1.05)
	var pitch_scale := random_factor * speed_scale
	shot_explosion.pitch_scale = pitch_scale * 1.55
	shell_bounce.pitch_scale = pitch_scale * 1.0

func update_speed_scale(new_speed_scale: float) -> void:
	speed_scale = new_speed_scale
	animation_player.speed_scale = speed_scale
