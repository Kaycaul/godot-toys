extends Node2D

# TODO: add particle system explosion with gravity when you shoot him
# TODO: count how many successful shots the player gets on the jumpscare and display score on hud
# TODO: make him expand or something to indicate how long you have to shoot
# TODO: end the game (and restart) when you miss your window to shoot
# TODO: glass shattering sound when you kill him
# TODO: define game speed scale with a literal difficulty curve
# TODO: overly dramatic synthwave music or something lmao

@onready var sneaks_scare: SneaksScare = %sneaks_scare
@onready var space_prompt: Label = %space_prompt
@onready var gun: Gun = %gun

var displaying_jumpscare := false
var game_speed_scale := 1.0
var hold_to_shoot := false

func _ready() -> void:
	sneaks_scare.begin_scare_timer()
	sneaks_scare.on_jumpscare.connect(on_jumpscare)
	space_prompt.hide()

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
		hide_jumpscare()
		# TODO: gain a point
		multiply_game_speed(1.025)

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
