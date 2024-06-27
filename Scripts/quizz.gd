extends Control

const Electives = preload("res://Scripts/enums/electives.gd")
const TIMER_SECONDS = 30

var current_question = {
	"index": -1,
	"correct_option_index": -1
}

var questions: Array[Elective] = []
@onready var question = $panel/quiz_container/Question
@onready var options = $panel/quiz_container/Options
@onready var timer = $Timer
@onready var pb = $timer_panel/pb
@onready var option_1 = $panel/quiz_container/Options/HBoxContainer/Option1
@onready var sounds = {
	&"correct_answer": AudioStreamPlayer.new(),
	&"wrong_answer": AudioStreamPlayer.new()
}
@onready var quiz_container = $panel/quiz_container
@onready var timer_panel = $timer_panel
@onready var start_button = $panel/start_button

var DEFAULT_BUTTON_THEME_NORMAL;
var DEFAULT_BUTTON_THEME_PRESSED;
var DEFAULT_BUTTON_THEME_HOVER;

const CORRECT_ANSWER_BUTTON = preload("res://assets/tema-opcao-questao/correct_answer_button.tres")
const WRONG_ANSWER_BUTTON = preload("res://assets/tema-opcao-questao/wrong_answer_button.tres")
@onready var quiz_music = $QuizMusic
var question_answered = false

func _ready():
	print("loading questions ")
	var selected_elective: String = Dialogic.VAR.elective
	var selected_parent_elective: String = Dialogic.VAR.parent_elective
	if not selected_elective or not selected_parent_elective:
		return
	print(pb.value)
	

func start_quiz():
	var selected_elective: String = Dialogic.VAR.elective
	var selected_parent_elective: String = Dialogic.VAR.parent_elective

	timer_panel.visible = true
	quiz_container.visible = true
	start_button.visible = false
	load_questions(selected_elective)
	quiz_music.play()
	DEFAULT_BUTTON_THEME_NORMAL = option_1.get_theme_stylebox("normal")
	DEFAULT_BUTTON_THEME_PRESSED = option_1.get_theme_stylebox("pressed")
	DEFAULT_BUTTON_THEME_HOVER = option_1.get_theme_stylebox("hover")
	for i in sounds.keys():
		sounds[i].stream = load("res://assets/sounds/quizz/" + str(i) + ".wav")
		sounds[i].bus = "master"
		add_child(sounds[i])
	

func _process(delta):
	#print(pb.value)
	#print(timer.time_left)
	if(timer_panel.visible):
		pb.value = timer.time_left
	pass

func reset_timer():
	timer.start(pb.value)
	
func load_questions(elective: String):
	questions = Electives.get_elective_questions(elective)
	current_question["index"] = 0
	current_question["correct_option_index"] = questions[0].correct_option_index
	change_question(questions[0])
#
func next_question():
	var current_question_index = current_question["index"]
	## acabou as questãa ;P
	print(current_question_index)
	if current_question_index >= questions.size() - 1:
		print("ACABO")
		Dialogic.signal_event.emit("end_quiz")
		return
		
		
	var elective: Elective = questions[current_question_index + 1]
	current_question["index"] = current_question_index + 1
	current_question["correct_option_index"] = questions[current_question_index + 1].correct_option_index
	change_question(elective)

func get_options():
	var buttons: Array[Button]
	var options = options.get_children()
	buttons.append_array(options[0].get_children())
	buttons.append_array(options[1].get_children())
	return buttons	

func change_question(elective: Elective):
	question.text = elective.question
	var buttons = get_options()
	print(buttons)
	for idx in range(buttons.size()):
		var b = buttons[idx]
		var label = b.get_child(0).get_child(0)
		label.text = elective.options[idx]
		print(label.text)
		reset_button_style(b)
	question_answered = false
	reset_timer()
	

func reset_button_style(button: Button):
	print(button)
	button.disabled = false
	button.add_theme_stylebox_override("normal",DEFAULT_BUTTON_THEME_NORMAL)
	button.add_theme_stylebox_override("pressed",DEFAULT_BUTTON_THEME_PRESSED)
	button.add_theme_stylebox_override("hover",DEFAULT_BUTTON_THEME_HOVER)

func handle_answer_question(selected_answer_index: int):
	var answered_correctly;
	if question_answered == false:
		question_answered = true
		if selected_answer_index == current_question["correct_option_index"]:
			const CORRECT_ANSWER_SCORE = 100
			Game.add_score(CORRECT_ANSWER_SCORE * (timer.time_left / 10))
			answered_correctly = true
		else:
			answered_correctly = false
		#next_question()
		handle_feedback(answered_correctly,selected_answer_index,
		current_question["correct_option_index"])
	

func handle_feedback(answered_correctly: bool, button_index_pressed: int, button_correct_answer_index: int):
	var buttons = get_options()
	print(buttons)
	print(answered_correctly)
	print(button_index_pressed)
	print(button_correct_answer_index)
	var pressed_button: Button = buttons[button_index_pressed]
	var correct_answer_button: Button = buttons[button_correct_answer_index]
	if answered_correctly:
		pressed_button.add_theme_stylebox_override("normal",CORRECT_ANSWER_BUTTON)
		pressed_button.add_theme_stylebox_override("pressed",CORRECT_ANSWER_BUTTON)
		pressed_button.add_theme_stylebox_override("hover",CORRECT_ANSWER_BUTTON)
		print(sounds)
		sounds["correct_answer"].play()
	else:
		if(button_index_pressed > -1):
			pressed_button.add_theme_stylebox_override("normal",WRONG_ANSWER_BUTTON)
			pressed_button.add_theme_stylebox_override("pressed",WRONG_ANSWER_BUTTON)
			pressed_button.add_theme_stylebox_override("hover",WRONG_ANSWER_BUTTON)
			
		correct_answer_button.add_theme_stylebox_override("normal", CORRECT_ANSWER_BUTTON)
		correct_answer_button.add_theme_stylebox_override("hover", CORRECT_ANSWER_BUTTON)
		sounds["wrong_answer"].play()
	timer.stop()
	pressed_button.release_focus()
	await wait(0.75)
	next_question()

func _on_option_1_pressed():
	handle_answer_question(0)
	pass # Replace with function body.

func wait(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout

func _on_option_2_pressed():
	handle_answer_question(1)
	pass # Replace with function body.


func _on_option_3_pressed():
	handle_answer_question(2)
	pass # Replace with function body.


func _on_option_4_pressed():
	handle_answer_question(3)
	pass # Replace with function body.


func _on_timer_timeout():
	handle_answer_question(-1)
	
	pass # Replace with function body.


func _on_button_pressed():
	start_quiz()
	
	pass # Replace with function body.


