extends RigidBody2D

@export var texture : Texture2D
@export var squish_duration : float
@export var squish_curve : Curve
@onready var sprite_container : Node2D = %SpriteContainer
@onready var sprite : Sprite2D = %Sprite
@onready var collider : CollisionShape2D = %Collider
var squishing := false
var time_since_started_squish := 0.0

func _ready() -> void:
	sprite.texture = texture

func _process(delta: float) -> void:
	if Input.is_action_pressed("ui_accept") and not squishing:
		squishing = true
		time_since_started_squish = 0.0
		if squish_duration > 0.03: squish_duration *= 0.9
		else: squish_duration = randf() * 0.5 + 1.3
	if squishing: squish(delta)

func squish(delta: float) -> void:
	time_since_started_squish += delta
	if time_since_started_squish >= squish_duration:
		squishing = false
		apply_torque_impulse(randf_range(-20, 20))
	else:
		var t := time_since_started_squish / squish_duration
		var squish_factor := squish_curve.sample(t)
		sprite_container.scale.y = squish_factor
		collider.scale.y = sprite_container.scale.y
		var sprite_height : int = sprite.texture.get_height()
		collider.position.y = sprite_height * -0.5 * squish_factor
		sprite_container.scale.x = 1.0 + (1.0 - squish_factor) * 0.2
		collider.scale.x = sprite_container.scale.x
