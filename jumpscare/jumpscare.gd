extends Node2D

# TODO: end the game (and restart) when you miss your window to shoot
# TODO: define game speed scale with a literal difficulty curve
# TODO: overly dramatic synthwave music or something lmao

const GLASS_EXPLODE_1 : AudioStreamMP3 = preload("uid://b2q6blgrn1r5s")
const GLASS_EXPLODE_2 : AudioStreamMP3 = preload("uid://bkpeht7vfo72")
const GLASS_EXPLODE_3 : AudioStreamMP3 = preload("uid://d1bkem0ju4b3u")
const GLASS_EXPLODE_4 : AudioStreamMP3 = preload("uid://dwwn3v3umc3vp")
const GLASS_EXPLODE_5 : AudioStreamMP3 = preload("uid://r0rvyfhefwcx")
const GLASS_EXPLODE_6 : AudioStreamMP3 = preload("uid://dq3xd7hhe8niy")
const GLASS_EXPLODE_7 : AudioStreamMP3 = preload("uid://rw7o60tsboxk")
const EXPLODE_SOUNDS = [
	GLASS_EXPLODE_1, 
	GLASS_EXPLODE_2, 
	GLASS_EXPLODE_3,
	GLASS_EXPLODE_4,
	GLASS_EXPLODE_5,
	GLASS_EXPLODE_6,
	GLASS_EXPLODE_7
]

@onready var sneaks_scare: SneaksScare = %sneaks_scare
@onready var space_prompt: Label = %space_prompt
@onready var gun: Gun = %gun
@onready var score_label: Label = %ScoreLabel
@onready var kill_sound: AudioStreamPlayer = %KillSound

var on_hit_particle_explosion : Resource = preload("uid://bfe05b5oab0la")

var displaying_jumpscare := false
var game_speed_scale := 1.0
var hold_to_shoot := false
var score := 0

func _ready() -> void:
	sneaks_scare.begin_scare_timer()
	sneaks_scare.on_jumpscare.connect(on_jumpscare)
	space_prompt.hide()
	score_label.text = ""

func _input(event: InputEvent) -> void:
	attempt_to_shoot(event)

func attempt_to_shoot(event: InputEvent) -> void:
	# attempt to cast to key event
	var key_event := event as InputEventKey
	if not key_event: return
	# check if the key is space
	if not key_event.keycode == KEY_SPACE: return
	# check if the key was just pressed
	if not key_event.is_pressed(): return
	if event.is_echo() and not hold_to_shoot: return
	shoot()

func shoot() -> void:
	if gun.is_reloading(): return # TODO: play fail sound here
	gun.shoot()
	if displaying_jumpscare:
		shoot_jumpscare()

## called on a successful hit on the enemy
func shoot_jumpscare() -> void:
	hide_jumpscare()
	spawn_explosion()
	gain_points(1)
	multiply_game_speed(1.1)
	play_random_hit_sound()

func play_random_hit_sound() -> void:
	kill_sound.stream = EXPLODE_SOUNDS.pick_random()
	kill_sound.play()

func gain_points(points: int) -> void:
	score += points
	update_score_label()

func update_score_label() -> void:
	score_label.text = "score: " + str(score)

## spawn the particle system explosion when shooting the jumpscare
func spawn_explosion() -> void:
	var new_explosion : JumpscareExplosion = on_hit_particle_explosion.instantiate()
	new_explosion.position = sneaks_scare.position
	add_child(new_explosion)

func multiply_game_speed(amount) -> void:
	game_speed_scale *= amount
	gun.update_speed_scale(game_speed_scale)
	sneaks_scare.update_speed_scale(game_speed_scale)
	if game_speed_scale > 10.0:
		hold_to_shoot = true

func hide_jumpscare() -> void:
	displaying_jumpscare = false
	space_prompt.hide()
	sneaks_scare.begin_scare_timer()

func on_jumpscare() -> void:
	displaying_jumpscare = true
	space_prompt.show()
