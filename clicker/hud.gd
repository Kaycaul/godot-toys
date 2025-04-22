extends CanvasLayer

@onready var money_label : Label = %"money counter"
@onready var purchase_spawner_button : Button = %"purchase spawner"
@onready var faster_button : Button = %"faster button"
@onready var gravity_button : Button = %"gravity button"
@onready var cheat_button : Button = %"cheat button"

signal on_spawner_purchase
signal on_new_spawner_wait_time(new_wait_time : float)
signal on_new_belt_speed(new_speed : int)
signal on_new_gravity(new_gravity : int)

var wega_cash := 0
var curent_force := 1200
var speed_increase_cost : int = 10
var gravity_increase_cost : int = 25
var current_wega_gravity : float = 1.0
var spawner_purchased := false
var spawn_speed_increase_cost := 50
var spawner_wait_time := 0.2

func _ready() -> void:
	update_gravity_button_text()

func gain_points(points : int) -> void:
	wega_cash += points
	money_label.text = "Wega Cash: " + str(wega_cash)

func gain_point() -> void:
	gain_points(1)

## called by clicking the button, after purchasing just speeds it up
func attempt_spawner_purchase() -> void:
	if not spawner_purchased:
		purchase_spawner()
	else:
		attempt_spawner_speed_increase()

func purchase_spawner() -> void:
	if wega_cash < 50: return
	spawner_purchased = true
	gain_points(-50)
	on_spawner_purchase.emit()
	on_new_spawner_wait_time.emit(spawner_wait_time)

func attempt_spawner_speed_increase() -> void:
	if wega_cash < spawn_speed_increase_cost: return
	gain_points(-spawn_speed_increase_cost)
	spawner_wait_time *= 0.5
	spawn_speed_increase_cost = (int)(1.5 * spawn_speed_increase_cost)
	on_new_spawner_wait_time.emit(spawner_wait_time)

func update_speed_up_button_label() -> void:
	purchase_spawner_button.text = "SPAWN MORE!! ($" + str(spawn_speed_increase_cost) + ")"

func attempt_speed_increase() -> void:
	if wega_cash < speed_increase_cost: return
	gain_points(-speed_increase_cost)
	curent_force *= 2
	speed_increase_cost = (int)(1.5 * speed_increase_cost)
	faster_button.text = "FASTER ($" + str(speed_increase_cost) + ")"
	on_new_belt_speed.emit(curent_force)

func attempt_gravity_increase() -> void:
	if wega_cash < gravity_increase_cost: return
	gain_points(-gravity_increase_cost)
	current_wega_gravity *= 2
	gravity_increase_cost = (int)(1.5 * gravity_increase_cost)
	update_gravity_button_text()
	on_new_gravity.emit(current_wega_gravity)

func update_gravity_button_text() -> void:
	gravity_button.text = "GRAVITY UP ($" + str(gravity_increase_cost) + ")"

func set_gravity_of_wega(wega : RigidBody2D) -> void:
	wega.gravity_scale = current_wega_gravity

func set_speed_fast_cheat() -> void:
	Engine.time_scale = 4.0
	Engine.physics_ticks_per_second = 240

func set_speed_normal_cheat() -> void:
	Engine.time_scale = 1.0
	Engine.physics_ticks_per_second = 60
