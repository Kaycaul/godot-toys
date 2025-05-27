extends Node2D
class_name SneaksScare

signal on_jumpscare

@export var initial_cooldown: float = 1.0

@onready var jumpscare_timer: Timer = %Timer
@onready var sprite: Sprite2D = %sprite
@onready var scream: AudioStreamPlayer = %scream

var cooldown : float
var speed_scale := 1.0
var displaying_jumpscare := false

func _ready() -> void:
	jumpscare_timer.timeout.connect(activate_jumpscare)
	cooldown = initial_cooldown
	reset_jumpscare()

func _process(delta : float) -> void:
	widen_while_visible(delta)

var time_since_jumpscare_start := 0.0
@onready var original_width_scale := sprite.scale.x
func widen_while_visible(delta : float) -> void:
	if not displaying_jumpscare: return
	var true_scream_duration := scream.stream.get_length() / speed_scale
	var scream_sound_progress := time_since_jumpscare_start / true_scream_duration
	# TODO: transform `scream_sound_progress` here with a [0,1]->[0,1] curve
	var new_width_scale := original_width_scale * (1 + scream_sound_progress)
	sprite.scale.x = new_width_scale
	time_since_jumpscare_start += delta

func reset_jumpscare() -> void:
	displaying_jumpscare = false
	sprite.hide()
	scream.stop()
	# reset stretching visual
	sprite.scale.x = original_width_scale

func begin_scare_timer(new_cooldown: float = -1.0) -> void:
	if new_cooldown > 0.0: cooldown = new_cooldown
	reset_jumpscare()
	var scare_delay := cooldown * randf_range(0.8, 1.6)
	scare_delay /= speed_scale
	jumpscare_timer.start(scare_delay)

func activate_jumpscare() -> void:
	on_jumpscare.emit()
	displaying_jumpscare = true
	# reveal sprite
	sprite.material.set_shader_parameter("flashing", true)
	sprite.material.set_shader_parameter("wega_color", true)
	sprite.visible = true
	# play scream sound
	scream.pitch_scale = randf_range(0.96, 1.04) * speed_scale
	scream.play()
	# cache the initial width so it can be reset later
	original_width_scale = sprite.scale.x
	time_since_jumpscare_start = 0.0

func update_speed_scale(new_speed_scale: float) -> void:
	speed_scale = new_speed_scale
