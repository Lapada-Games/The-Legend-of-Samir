extends Node2D

signal success
signal failed
signal ended

var rng = RandomNumberGenerator.new()
var has_answered = false
var disabled = false
var index = 0
var current_question = 0
var operations_length = 8
enum {
	SUM,
	SUB,
	MUL,
	DIV
}

var positions = [
	Vector2(406, 57),
	Vector2(406, 130),
	Vector2(406, 202)
]

var operations = [
	["2 + 2", "3 + 4"],
	["1 + 3", "4 - 1"]
]

var answers = [1, 0]

func _ready():
	setup(3, 5)

func setup(player_hp, boss_hp):
	operations_length = player_hp + boss_hp
	generate_operations()
	generate_answers()
	render()

func generate_operations():
	var operations = []
	for i in range(operations_length):
		
		var sign = rng.randi_range(0, 3)
		operations.append([])
		
		var operation = ""
		for j in range(2):
			var new_operation = operation_string_generator(sign)
			operation = new_operation
			operations[i].append(operation)
	
	self.operations = operations
	
	

func generate_answers():
	var answers = []
	for pair in self.operations:
		var first = get_answer_from_string(pair[0])
		var second = get_answer_from_string(pair[1])
	
		if first > second:
			answers.append(0)
		elif first == second:
			answers.append(1)
		else:
			answers.append(2)
	self.answers = answers
func get_answer_from_string(string: String):
	
	var n1 = int(string.split(" ")[0])
	var n2 = int(string.split(" ")[2])
	var sign = string.split(" ")[1]
	
	if sign == "+":
		return int(n1) + int(n2)
	elif sign == "-":
		return int(n1) - int(n2)
	elif sign == "x":
		return int(n1) * int(n2)
	elif sign == "÷":
		return n1 / n2

func operation_string_generator(operation):
	var final_str = ""
	var range = [1, 10]
	
	if operation == SUM:
		if Global.difficulty == Global.MEDIUM:
			range = [1, 20]
		elif Global.difficulty == Global.HARD:
			range = [20, 50]
		
		var n1 = rng.randi_range(range[0], range[1])
		var n2 = rng.randi_range(range[0], range[1])
		
		final_str = str(n1) + " + " + str(n2)
		
		return final_str
		
	elif operation == SUB:
		if Global.difficulty == Global.MEDIUM:
			range = [1, 20]
		elif Global.difficulty == Global.HARD:
			range = [20, 50]
		
		var n1 = rng.randi_range(range[0], range[1])
		var n2 = rng.randi_range(range[0], range[1])
		
		# this forces that every subtraction will result a positive integer
		if n1 > n2:
			final_str = str(n1) + " - " + str(n2)
		else:
			final_str = str(n2) + " - " + str(n1)
		
		return final_str
		
	elif operation == MUL:
		if Global.difficulty == Global.MEDIUM or Global.difficulty == Global.HARD:
			range = [2, 9]
		
		var n1 = rng.randi_range(range[0], range[1])
		var n2 = rng.randi_range(range[0], range[1])
		
		final_str = str(n1) + " x " + str(n2)
		
		return final_str
		
	elif operation == DIV:
		if Global.difficulty == Global.MEDIUM or Global.difficulty == Global.HARD:
			range = [2, 9]
		
		var n1 = rng.randi_range(range[0], range[1])
		var n2 = rng.randi_range(range[0], range[1])
		
		n1 *= n2
		
		final_str = str(n1) + " ÷ " + str(n2)
		
		return final_str

func render():
	$Operation1/Label.text = operations[current_question][0]
	$Operation2/Label.text = operations[current_question][1]

func _process(delta):
	if not has_answered and not disabled:
		if Input.is_action_just_pressed("ui_up"):
			index -= 1
			if index < 0: index = 0 # clamping
			update_cursor()
		if Input.is_action_just_pressed("ui_down"):
			index += 1
			if index > 2: index = 2
			update_cursor()
		
		if Input.is_action_just_pressed("ui_accept"):
			check()

func update_cursor():
	$Selection.position = positions[index]

func next_question():
	current_question += 1
	has_answered = false
	$Timer.frame = 0
	$Timer.play("default")
	if current_question >= len(operations):
		emit_signal("ended")
		has_answered = true
		$Timer.queue_free()
		$Operation1.visible = false
		$Operation2.visible = false
		$Option1.visible = false
		$Option2.visible = false
		$Selection.visible = false
		return
	render()

func check():
	has_answered = true
	if index == answers[current_question]:
		emit_signal("success")
		$Timer.frame = 0
		$Timer.pause()
		$Operation1/Label.text = "CORRETO"
		$Operation2/Label.text = "CORRETO"
	else:
		emit_signal("failed")
		
		$Operation1/Label.text = "ERRADO"
		$Operation2/Label.text = "ERRADO"


func _on_animated_sprite_2d_animation_finished():
	if not disabled:
		has_answered = true
		emit_signal("failed")
		$Timer.frame = 0
		$Timer.pause()
		$Operation1/Label.text = "TEMPO"
		$Operation2/Label.text = "ACABOU"
