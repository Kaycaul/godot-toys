extends Node2D
class_name SneaksScare

signal on_jumpscare

@export var initial_cooldown: float = 1.0

@onready var jumpscare_timer: Timer = %Timer
@onready var sprite: Sprite2D = %sprite
@onready var scream: AudioStreamPlayer = %scream

var cooldown : float
var speed_scale := 1.0

func _ready() -> void:
	jumpscare_timer.timeout.connect(activate_jumpscare)
	cooldown = initial_cooldown
	reset_jumpscare()

func reset_jumpscare() -> void:
	sprite.hide()
	scream.stop()

func begin_scare_timer(new_cooldown: float = -1.0) -> void:
	if new_cooldown > 0.0: cooldown = new_cooldown
	reset_jumpscare()
	var scare_delay := cooldown * randf_range(0.8, 1.6)
	scare_delay /= speed_scale
	jumpscare_timer.start(scare_delay)

func activate_jumpscare() -> void:
	on_jumpscare.emit()
	# reveal sprite
	sprite.material.set_shader_parameter("flashing", true)
	sprite.material.set_shader_parameter("wega_color", true)
	sprite.visible = true
	# play scream sound
	scream.pitch_scale = randf_range(0.96, 1.04) * speed_scale
	scream.play()

func update_speed_scale(new_speed_scale: float) -> void:
	speed_scale = new_speed_scale
