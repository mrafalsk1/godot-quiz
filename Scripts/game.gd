extends Node

signal game_started

var elective := ''
var current_scene = null
@onready var menu = $"../Menu"
@onready var timeline_manager = $"../TimelineManager"
@onready var quizz = $"../Quizz"


func _ready():
	print("ready")
	game_started.emit()



func select_elective(selected_elective: String):
	elective = selected_elective


