extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	_destroy_bullets()

func _destroy_bullets() -> void:
	var numBulletsForDestruction : int = 0
	var bulletsNodes : Array[Node] = get_children()
	var destroyBullet : bool = false
	var bulletArrSize = bulletsNodes.size()
	#Swap bullet node to be destroyed with the last element in the array.
	for k in bulletArrSize:
		destroyBullet = false
		var bulletPos : Vector2 = bulletsNodes[k].get_child(0).position
		if bulletPos.x < (-(ScreenWrapperHelper.viewportSize.x / 2) - 50.0):
			destroyBullet = true
		elif bulletPos.x > ((ScreenWrapperHelper.viewportSize.x / 2) + 50.0):
			destroyBullet = true
		elif bulletPos.y < (-(ScreenWrapperHelper.viewportSize.y / 2) - 50.0):
			destroyBullet = true
		elif bulletPos.y > ((ScreenWrapperHelper.viewportSize.x / 2) + 50.0):
			destroyBullet = true
		if destroyBullet == true:
			var tempNode : Node2D = bulletsNodes[k]
			bulletsNodes[k] = bulletsNodes[bulletArrSize - 1 - numBulletsForDestruction]
			bulletsNodes[bulletArrSize - 1 - numBulletsForDestruction] = tempNode
			numBulletsForDestruction += 1

	#Remove all elements from the back end of the array!
	for k in bulletArrSize:
		if k > (bulletArrSize - 1 - numBulletsForDestruction):
			bulletsNodes.remove_at(k)
			remove_child(get_child(k))
