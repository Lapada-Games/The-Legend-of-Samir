extends Node2D


@onready var enemy = preload("res://Scenes/Enemy.tscn")
var instance = null


# Called when the node enters the scene tree for the first time.
func _ready():
	spawn_enemy()


func spawn_enemy():
	instance = enemy.instantiate()
	add_child(instance)

func has_enemy():
	return instance != null

func delete_enemy():
	instance.queue_free()
