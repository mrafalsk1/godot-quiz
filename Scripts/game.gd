extends Node

signal game_started
signal end_quiz

var elective := ''
const File = preload("res://Scripts/file.gd")
const RANKS_FILE_PATH = "res://Database/Ranks.json"
@export var score = 0

func _ready():
	print("ready")
	game_started.emit()


func add_score(elective_score: int):
	score += elective_score	

func save_score(elective: String):
	
	var file_manager = File.new()
	var ranks = file_manager.read_file(RANKS_FILE_PATH)

	if score > int(ranks[elective]):
		ranks[elective] = score
		file_manager.save_file(RANKS_FILE_PATH, ranks)
	score = 0

func select_elective(selected_elective: String):
	elective = selected_elective
	


