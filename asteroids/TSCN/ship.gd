extends RigidBody2D

const BULLET_SCENE = preload("res://TSCN/bullet.tscn")

@export var forward_vector : Vector2 = -global_transform.y
@export var ship_speed : float = 0.0
@export var bullet_speed : float = 0.0
@export var rotationRadian : float = 0.0

@export var rotateLeft : bool = false
@export var rotateRight : bool = false
@export var propelForward : bool = false
@export var propelBack : bool = false

@export var infiniteMax : Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#1 degree in radians * 10.
	rotationRadian = 0.174533
	infiniteMax = Vector2(-9000.0, -9000.0)
	ScreenWrapperHelper._set_viewport_size(get_viewport().get_visible_rect().size)
	bullet_speed = 100.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var tempPos : Vector2 = ScreenWrapperHelper._get_new_position(position)
	#Do not reset position if already on same position to make sure the physics code does not get overwritten!!
	if tempPos.x < infiniteMax.x && tempPos.y < infiniteMax.y:
		return
	#Update to new position based on screen wrapping!
	position = tempPos

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
	if _event is InputEventKey && _event.keycode == KEY_SPACE:
		if _event.is_pressed():
			var bullet_instance = BULLET_SCENE.instantiate()
			bullet_instance.global_position.x = global_position.x
			bullet_instance.global_position.y = global_position.y
			get_tree().current_scene.get_child(1).add_child(bullet_instance)
			var bulletRB2D : RigidBody2D = bullet_instance.get_child(0) as RigidBody2D
			bulletRB2D.add_constant_force(forward_vector * bullet_speed)
