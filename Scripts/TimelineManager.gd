extends Node

const MINIGAME_SCENE = preload("res://Scenes/quizz.tscn")
const END_QUIZ_SCENE = preload("res://Scenes/show_results.tscn")
var minigame = MINIGAME_SCENE.instantiate()

func _ready():
	print("fdggfd")

func start_minigame() -> void:
	add_child(minigame)


func _on_game_manager_game_started():
	print("game started")
	if Dialogic.current_timeline != null:
		return
	Dialogic.start('timeline')
	get_viewport().set_input_as_handled()
	Dialogic.signal_event.connect(_on_dialogic_signal_event)
	#Dialogic.timeline_ended.connect(_on_time_line_ended)

func _on_dialogic_signal_event(argument: String):
	if argument == "start_quiz":
		_on_start_quiz()
	if argument == "end_quiz":
		_on_end_quiz()



func _on_start_quiz():
	start_minigame()
	
func _on_end_quiz():
	remove_child(minigame)
	var scene = END_QUIZ_SCENE.instantiate()
	add_child(scene)
	
	
#
#func _on_time_line_ended():
	#print("mini_game")
	#start_minigame()













