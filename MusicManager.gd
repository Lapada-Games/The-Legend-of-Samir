extends Node

@onready var audio = $Theme
var streams = [
	load("res://Assets/Audio/Level1.mp3"),
	load("res://Assets/Audio/Level2.mp3"),
	load("res://Assets/Audio/Level3.mp3"),
	load("res://Assets/Audio/Level4.mp3")
]

var paused = true

func play(level):
	if paused:
		audio.stream = streams[level]
		audio.play()
		paused = false

func stop():
	if not paused:
		audio.playing = false
		paused = true
