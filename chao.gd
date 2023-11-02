extends TileMap


# Called when the node enters the scene tree for the first time.
func _ready():
	print(position.x)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.x -= 50 * delta
	
	if position.x < -768:
		position.x = 0
