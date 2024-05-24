extends Node

signal game_started
signal end_quiz

var elective := ''
var current_scene = null
@export var score = 0
@onready var menu = $"../Menu"
@onready var timeline_manager = $"../TimelineManager"
@onready var quizz = $"../Quizz"

func _ready():
	print("ready")
	game_started.emit()


func add_score(elective_score: int):
	print(score)
	score += elective_score	


func select_elective(selected_elective: String):
	elective = selected_elective
	
func _end_quiz():
	print("aloooo")
	end_quiz.emit()


