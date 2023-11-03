extends Node2D

var level_names = [
	"PRAIA DA ADIÇÃO",
	"PLANÍCIE DA SUBTRAÇÃO",
	"VALES DA MULTIPLICAÇÃO",
	"ESTRADA DA DIVISÃO"
]

# Called when the node enters the scene tree for the first time.
func _ready():
	$Label.text = level_names[Global.level]


func _on_audio_stream_player_finished():
	get_tree().change_scene_to_file("res://Scenes/Levels/level" + str(Global.level + 1) + ".tscn") # TODO: change this later
