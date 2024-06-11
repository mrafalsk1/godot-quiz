extends Control

const Electives = preload("res://Scripts/enums/electives.gd")
const TIMER_SECONDS = 30

var current_question = {
	"index": -1,
	"correct_option_index": -1
}
var questions: Array[Elective] = []
@onready var options = $VBoxContainer/Options
@onready var question = $VBoxContainer/Question
@onready var timer = $Timer
@onready var timer_label = $TimerLabel


func _ready():
	print("loading questions ")
	var selected_elective: String = Dialogic.VAR.elective
	var selected_parent_elective: String = Dialogic.VAR.parent_elective
	if not selected_elective or not selected_parent_elective:
		return
	load_questions(selected_elective,selected_parent_elective)
	
func _process(delta):
	timer_label.text = "%s" % roundf(timer.time_left)

func reset_timer():
	timer.start(TIMER_SECONDS)
	
func load_questions(elective: String, parent_elective: String):
	questions = Electives.get_elective_questions(elective,parent_elective)
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
		## TODO change to scenarioa end quizz
		return
		
		
	var elective: Elective = questions[current_question_index + 1]
	current_question["index"] = current_question_index + 1
	current_question["correct_option_index"] = questions[current_question_index + 1].correct_option_index
	change_question(elective)

func change_question(elective: Elective):
	question.text = elective.question
	var buttons = options.get_children()	
	for idx in range(buttons.size()):
		var b = buttons[idx]
		b.text = elective.options[idx]

	reset_timer()

func handle_answer_question(selected_answer_index: int):
	if selected_answer_index == current_question["correct_option_index"]:
		## TODO feedbacks 	
		const CORRECT_ANSWER_SCORE = 100
		Game.add_score(CORRECT_ANSWER_SCORE * (timer.time_left / 10))
		print("acerto mizerávi")
	else:
		print("erro")
	next_question()
	

func _on_option_1_pressed():
	handle_answer_question(0)
	pass # Replace with function body.


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
