extends ParallaxBackground

var paused = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not paused:
		scroll_base_offset += Vector2(-50, 0) * delta
