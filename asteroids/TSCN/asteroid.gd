extends RigidBody2D

@export var forward_vector = -global_transform.y
@export var force_range : float = 0.0

@export var directionRight : int = false
@export var rotationRadian : float = 0.0
@export var firstRotation : float = 0.0
@export var infiniteMax : Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	infiniteMax = Vector2(-9000.0, -9000.0)
	#1 degree in radians.
	rotationRadian = 0.0174533
	directionRight = randi_range(0, 10)
	#Keeping value at 1/10 as max range and multiplying to get lesser range of angles for each asteroid!
	firstRotation = randf_range(0.0, 0.628319) * 10.0
	#Apply force on spawning!
	force_range = randf_range(5.0, 20.0)
	#apply_force(forward_vector * force_range)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var tempPos : Vector2 = ScreenWrapperHelper._get_new_position(position)
	#Do not reset position if already on same position to make sure the physics code does not get overwritten!!
	if tempPos.x < infiniteMax.x && tempPos.y < infiniteMax.y:
		return
	#Update to new position based on screen wrapping!
	position = tempPos
	pass

func _physics_process(_delta: float) -> void:
	apply_force(forward_vector * force_range)
	if directionRight < 5:
		rotate(rotationRadian)
	else:
		rotate(-rotationRadian)
