extends Node2D

var index = 0

var options = [
	" > Fácil\n   Médio\n   Difícil",
	"   Fácil\n > Médio\n   Difícil",
	"   Fácil\n   Médio\n > Difícil",
]

var labels = [
	"Inimigos lentos, contas simples,\nníveis curtos",
	"Inimigos rápidos, contas normais\nníveis médios",
	"Inimigos muito rápidos, contas\ndifíceis, níveis longos",
]

func _ready():
	update_selection()


func update_selection():
	$Label2.text = options[index]
	$Label3.text = labels[index]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	$ParallaxBackground.scroll_base_offset += Vector2(-50, 0) * delta
	
	if Input.is_action_just_pressed("ui_down"):
		index += 1
		if index > 2:
			index = 0
		update_selection()
	
	if Input.is_action_just_pressed("ui_up"):
		index -= 1
		if index < 0:
			index = 2
		update_selection()
	
	if Input.is_action_just_pressed("ui_accept"):
		Global.difficulty = index
		get_tree().change_scene_to_file("res://Scenes/LevelShower.tscn")
	
