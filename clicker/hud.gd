extends CanvasLayer

@onready var money_label : Label = %"money counter"
@onready var purchase_spawner_button : Button = %"purchase spawner"
@onready var faster_button : Button = %"faster button"

signal on_spawner_purchase
signal on_new_belt_speed(new_speed : int)

var wega_cash := 0
var curent_force := 1200
var speed_increase_cost := 10

func gain_points(points : int) -> void:
	wega_cash += points
	money_label.text = "Wega Cash: " + str(wega_cash)

func gain_point() -> void:
	gain_points(1)

func attempt_spawner_purchase() -> void:
	if wega_cash < 50: return
	gain_points(-50)
	purchase_spawner_button.queue_free()
	on_spawner_purchase.emit()

func attempt_speed_increase() -> void:
	if wega_cash < speed_increase_cost: return
	gain_points(-speed_increase_cost)
	curent_force *= 2
	speed_increase_cost *= 1.5
	faster_button.text = "FASTER ($" + str(speed_increase_cost) + ")"
	on_new_belt_speed.emit(curent_force)
