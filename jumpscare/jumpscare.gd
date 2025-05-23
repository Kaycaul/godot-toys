extends Node2D

@onready var sneaks_scare: SneaksScare = %sneaks_scare
@onready var space_prompt: Label = %space_prompt

var displaying_jumpscare := false

func _ready() -> void:
	sneaks_scare.begin_scare_timer()
	sneaks_scare.on_jumpscare.connect(on_jumpscare)
	space_prompt.hide()

func _input(event: InputEvent) -> void:
	check_for_space_input(event)

func check_for_space_input(event: InputEvent) -> void:
	if not displaying_jumpscare: return
	# attempt to cast to key event
	var key_event := event as InputEventKey
	if not key_event: return
	# check if the key is space
	if not key_event.keycode == KEY_SPACE: return
	# check if the key was just pressed
	if not key_event.is_pressed(): return
	if event.is_echo(): return
	# hide the jumpscare
	hide_jumpscare()

func hide_jumpscare() -> void:
	displaying_jumpscare = false
	space_prompt.hide()
	sneaks_scare.begin_scare_timer()

func on_jumpscare() -> void:
	displaying_jumpscare = true
	space_prompt.show()
