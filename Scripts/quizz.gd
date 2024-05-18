extends Control
const Electives = preload("res://Scripts/enums/electives.gd")

var current_questions = 0
@onready var options = $VBoxContainer/Options
@onready var question = $VBoxContainer/Question



func _ready():
	var selected_elective: String = Dialogic.VAR.elective
	var selected_parent_elective: String = Dialogic.VAR.parent_elective
	if not selected_elective or not selected_parent_elective:
		return
	
	print("quiz game variavle MUTIO FODA")
	print(selected_elective)
	print(Electives.ELECTIVE_NAMES.values())
	
	#var elective_index =  Electives.ELECTIVE_NAMES.values().find(selected_elective)
	#if elective_index == -1:
		#return
	
	#var elective_name = Electives.ELECTIVE_NAMES.values().find(selected_elective)
	#var elective = Electives.ELECTIVE_NAMES.keys()[elective_name]
	load_questions(selected_elective,selected_parent_elective)
func load_questions(elective: String, parent_elective: String):
	var questions = Electives.get_elective_questions(elective,parent_elective)
	change_question(questions[0])
	print(questions)
	print(questions[0]["question"])
		
#
#func next_question():

func change_question(elective: Elective):
	print(elective)
	question.text = elective.question
	var buttons = options.get_children()	
	for idx in range(buttons.size()):

		var b = buttons[idx]
		b.text = elective.options[idx]
		print(b.text)
