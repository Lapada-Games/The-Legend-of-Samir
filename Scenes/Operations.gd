extends Node2D

signal success
signal failed
signal ended

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
		"13 - 5",
		"40 + 25",
		"110 - 30",
		"21 - 4",
		"99 - 69",
		"21 - 11"
	],
	# LEVEL 3
	[
		"7 x 8",
		"5 x 8",
		"9 x 9",
		"8 x 4",
		"20 x 3",
		"11 x 4"
	]
]

var answers = [
	# LEVEL 1
	[4, 5, 7, 27, 16, 35],
	# LEVEL 2
	[8, 65, 80, 17, 30, 10],
	# LEVEL 3
	[56, 40, 81, 32, 60, 44],
]


var positions = [
	Vector2(148, 202),
	Vector2(319, 202),
	Vector2(494, 202),
	Vector2(658, 202)
]

var index = 0
var current_question = 0
var has_answered = false

func _ready():
	update_cursor()
	
	render_operation()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not has_answered:
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
	$Selection.visible = true
	$Panel/Label.text = operations[Global.level][current_question] + " ="
	
	# set all options to be random numbers
	var random_answers = []
	for i in range(4):
		var random_answer = rng.randi_range(1, (Global.level + 1) * 20)
		
		while random_answer in random_answers or random_answer == answers[Global.level][current_question]:
			random_answer = rng.randi_range(1, (Global.level + 1) * 20)
		
		random_answers.append(random_answer)
	
		get_node("Option" + str(i + 1) + "/Label").text = str(random_answers[i])
	
	# choose a random index for being the answer
	var answer_index = rng.randi_range(0, 3)
	
	get_node("Option" + str(answer_index + 1) + "/Label").text = str(answers[Global.level][current_question])

func check():
	var option_text = get_node("Option" + str(index + 1) + "/Label").text
	
	if int(option_text) == answers[Global.level][current_question]:
		emit_signal("success")
		has_answered = true
		$Panel/Label.text = "CORRETO!!"
		$Option1/Label.text = ""
		$Option2/Label.text = ""
		$Option3/Label.text = ""
		$Option4/Label.text = ""
		$DelayBeforeNext.start()
		$Selection.visible = false
	else:
		has_answered = true
		$Panel/Label.text = "ERRADO :("
		$Option1/Label.text = ""
		$Option2/Label.text = ""
		$Option3/Label.text = ""
		$Option4/Label.text = ""
		emit_signal("failed")

func disable():
	has_answered = true
	$Panel/Label.text = "FALHOU"
	$Option1/Label.text = ""
	$Option2/Label.text = ""
	$Option3/Label.text = ""
	$Option4/Label.text = ""

func next_question():
	current_question += 1
	if current_question >= len(operations[Global.level]):
		emit_signal("ended")
		$Panel/Label.text = "GANHOU!"
		$Option1/Label.visible = false
		$Option2/Label.visible = false
		$Option3/Label.visible = false
		$Option4/Label.visible = false
		return
	render_operation()
	

func _on_test_timeout():
	emit_signal("success") # TESTE


func _on_delay_before_next_timeout():
	has_answered = false
