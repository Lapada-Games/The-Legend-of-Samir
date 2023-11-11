extends Node2D


func go_to_main_menu():
	Global.level = 0
	get_tree().change_scene_to_file("res://Scenes/Menu.tscn")
