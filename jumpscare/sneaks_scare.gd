extends Node2D
class_name SneaksScare

signal on_jumpscare

@export var initial_cooldown: float = 1.0

@onready var jumpscare_timer: Timer = %Timer
@onready var sprite: Sprite2D = %sprite
@onready var scream: AudioStreamPlayer = %scream

var cooldown

func _ready() -> void:
	jumpscare_timer.timeout.connect(activate_jumpscare)
	cooldown = initial_cooldown
	reset_jumpscare()

func reset_jumpscare() -> void:
	sprite.hide()
	scream.stop()

func begin_scare_timer(new_cooldown: float = -1.0) -> void:
	if new_cooldown != -1.0: cooldown = new_cooldown
	reset_jumpscare()
	jumpscare_timer.start(cooldown)

func activate_jumpscare() -> void:
	on_jumpscare.emit()
	# reveal sprite
	sprite.material.set_shader_parameter("flashing", true)
	sprite.material.set_shader_parameter("wega_color", true)
	sprite.visible = true
	# play scream sound
	scream.pitch_scale = randf_range(0.96, 1.04)
	scream.play()
	# TODO: add particle system explosion when you shoot him
	# TODO: give the player a gun and it takes like 0.3s to reload so they cant just spam
	# TODO: count how many successful shots the player gets on the jumpscare and display score on hud
	# TODO: speed up the game and increase the jumpscare pitch gradually
