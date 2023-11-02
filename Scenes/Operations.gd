extends Node2D

signal success

var rng = RandomNumberGenerator.new()

var operations = [
	# LEVEL 1
	[
		"2 + 2",
		"3 + 2",
		"1 + 6",
		"2 + 25",
		"11 + 5",
		"24 + 11"
	],
	# LEVEL 2
	[
		"5 + 5",
		"50 + 65",
		"10 + 32",
		"21 + 4",
		"6 + 9",
		"6 + 11",
	]
]

var answers = [
	# LEVEL 1
	[
		4,
		5,
		7,
		27,
		16,
		35
	]
]


var positions = [
	Vector2(148, 202),
	Vector2(319, 202),
	Vector2(494, 202),
	Vector2(658, 202)
]

var index = 0
var current_question = 0

func _ready():
	update_cursor()
	
	render_operation()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_left"):
		index -= 1
		if index < 0: index = 0 # clamping
		update_cursor()
	if Input.is_action_just_pressed("ui_right"):
		index += 1
		if index > 3: index = 3
		update_cursor()
	
	if Input.is_action_just_pressed("ui_up"):
		check()

func update_cursor():
	$Selection.position = positions[index]

func render_operation():
	$Panel/Label.text = operations[Global.level][current_question] + " ="
	
	# set all options to be random numbers
	var random_answers = []
	for i in range(4):
		random_answers.append(rng.randi_range(1, 20))
	
	# check for repeated values
	for i in range(3):
		for j in range(1, 4):
			print(i, j)
			if i == j: continue
			
			while random_answers[i] == random_answers[j] or random_answers[i] == answers[Global.level][current_question]:
				random_answers[i] = rng.randi_range(1, 20)
	
		get_node("Option" + str(i + 1) + "/Label").text = str(random_answers[i])
	
	# choose a random index for being the answer
	var answer_index = rng.randi_range(0, 3)
	print(answer_index)
	
	get_node("Option" + str(answer_index + 1) + "/Label").text = str(answers[Global.level][current_question])

func check():
	var option_text = get_node("Option" + str(index + 1) + "/Label").text
	
	if int(option_text) == answers[Global.level][current_question]:
		print("acertou")
		next_question()
	else:
		print("errou")

func next_question():
	current_question += 1
	render_operation()
	

func _on_test_timeout():
	emit_signal("success") # TESTE
