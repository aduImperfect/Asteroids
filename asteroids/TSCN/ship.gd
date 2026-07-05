extends RigidBody2D

@export var forward_vector = -global_transform.y
@export var rotationRadian : float = 0.0

@export var rotateLeft : bool = false
@export var rotateRight : bool = false
@export var propelForward : bool = false
@export var propelBack : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#1 degree in radians * 10.
	rotationRadian = 0.174533

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _physics_process(_delta: float) -> void:
	forward_vector = -global_transform.y
	if rotateLeft == true:
			rotate(rotationRadian)
			rotateLeft = false
	elif rotateRight == true:
			rotate(-rotationRadian)
			rotateRight = false
	elif propelForward == true:
			apply_impulse(forward_vector)
			propelForward = false
	elif propelBack == true:
			apply_impulse(-forward_vector)
			propelBack = false

func _input(_event: InputEvent) -> void:
	#rotate left
	if _event is InputEventKey && _event.keycode == KEY_D:
		if _event.is_pressed():
			rotateLeft = true
	#rotate right
	if _event is InputEventKey && _event.keycode == KEY_A:
		if _event.is_pressed():
			rotateRight = true
	#propel forwards
	if _event is InputEventKey && _event.keycode == KEY_W:
		if _event.is_pressed():
			propelForward = true
	#propel backwards
	if _event is InputEventKey && _event.keycode == KEY_S:
		if _event.is_pressed():
			propelBack = true
