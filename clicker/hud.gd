extends CanvasLayer

@onready var money_label : Label = %"money counter"
@onready var purchase_spawner_button : Button = %"purchase spawner"

signal on_spawner_purchase

var wega_cash := 0

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
