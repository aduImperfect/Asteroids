class_name ScreenWrapperHelper

static var screenWrapMinX : bool = false
static var screenWrapMinY : bool = false
static var screenWrapMaxX : bool = false
static var screenWrapMaxY : bool = false

static var viewportSize : Vector2
static var offset : float
static var resetOffset : float

static var screenInfiniteMax : Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

static func _set_viewport_size(vpSize : Vector2) -> void:
	viewportSize = vpSize
	#print(viewportSize)

static func _get_new_position(pos : Vector2) -> Vector2:
	offset = 50.0
	resetOffset = 10.0
	screenInfiniteMax = Vector2(-9999.0, -9999.0)

	var new_pos : Vector2 = Vector2(screenInfiniteMax.x, screenInfiniteMax.y)
	if pos.x > ((viewportSize.x / 2) + offset):
		screenWrapMaxX = true
	if screenWrapMaxX == true:
		new_pos.x = -((viewportSize.x / 2) + offset) + resetOffset
		new_pos.y = pos.y
		screenWrapMaxX = false

	if pos.y > ((viewportSize.y / 2) + offset):
		screenWrapMaxY = true
	if screenWrapMaxY == true:
		new_pos.x = pos.x
		new_pos.y = -((viewportSize.y / 2) + offset) + resetOffset
		screenWrapMaxY = false

	if pos.x < -((viewportSize.x / 2) + offset):
		screenWrapMinX = true
	if screenWrapMinX == true:
		new_pos.x = ((viewportSize.x / 2) + offset) - resetOffset
		new_pos.y = pos.y
		screenWrapMinX = false

	if pos.y < -((viewportSize.y / 2) + offset):
		screenWrapMinY = true
	if screenWrapMinY == true:
		new_pos.x = pos.x
		new_pos.y = ((viewportSize.y / 2) + offset) - resetOffset
		screenWrapMinY = false

	return new_pos
