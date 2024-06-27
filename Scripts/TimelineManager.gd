extends Node

const MINIGAME_SCENE = preload("res://Scenes/quiz.tscn")
const END_QUIZ_SCENE = preload("res://Scenes/show_results.tscn")
var minigame_scene
var show_results_scene


func _ready():
	print("timeline ready")

func start_minigame() -> void:
	var minigame = MINIGAME_SCENE.instantiate()
	add_child(minigame)
	
	minigame_scene = minigame


func _on_game_manager_game_started():
	print("game started")
	if Dialogic.current_timeline != null:
		return
	Dialogic.start('intro')
	get_viewport().set_input_as_handled()
	Dialogic.signal_event.connect(_on_dialogic_signal_event)
	#Dialogic.timeline_ended.connect(_on_time_line_ended)

func _on_dialogic_signal_event(argument: String):
	if argument == "start_quiz":
		_on_start_quiz()
	if argument == "end_quiz":
		_on_end_quiz()
	if argument == "next_quiz":
		print("next_quiz")
		remove_child(show_results_scene)
		print("next_quiz")
		_on_next_quiz()
	if argument == "end_game":
		Dialogic.VAR.count_elective = 0
		get_tree().change_scene_to_file("res://Scenes/menu.tscn")




func _on_start_quiz():
	start_minigame()
	
func _on_end_quiz():
	remove_child(minigame_scene)
	var scene = END_QUIZ_SCENE.instantiate()
	show_results_scene = scene
	add_child(scene)

	
func _on_next_quiz():
	var count_electives = Dialogic.VAR.count_elective
	print("count")
	print(count_electives)
	if int(count_electives) == 3:
		Dialogic.start("en")
	else: 
		if Dialogic.current_timeline != null:
			return
		Dialogic.start('after_quiz')
		get_viewport().set_input_as_handled()
		Dialogic.signal_event.connect(_on_dialogic_signal_event)
	
	
#
#func _on_time_line_ended():
	#print("mini_game")
	#start_minigame()













