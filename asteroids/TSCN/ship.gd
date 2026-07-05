extends RigidBody2D
#extends Node2D

@export var forward_vector = -global_transform.y
@export var rotationRadian : float = 0.0
#var rb2D : RigidBody2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#1 degree in radians * 10.
	rotationRadian = 0.174533
	#rb2D = get_child(1) as RigidBody2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _physics_process(_delta: float) -> void:
	forward_vector = -global_transform.y

func _input(_event: InputEvent) -> void:
	#rotate left
	if _event is InputEventKey && _event.keycode == KEY_D:
		if _event.is_pressed():
			rotate(rotationRadian)
	#rotate right
	if _event is InputEventKey && _event.keycode == KEY_A:
		if _event.is_pressed():
			rotate(-rotationRadian)
	#propel forwards
	if _event is InputEventKey && _event.keycode == KEY_W:
		if _event.is_pressed():
			apply_impulse(forward_vector)
	#propel backwards
	if _event is InputEventKey && _event.keycode == KEY_S:
		if _event.is_pressed():
			apply_impulse(-forward_vector)
