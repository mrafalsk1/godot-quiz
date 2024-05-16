extends Node

signal quizz

const MINIGAME_SCENE = preload("res://Scenes/quizz.tscn")

func _ready():
	print("fdggfd")

func start_minigame() -> void:
	var minigame = MINIGAME_SCENE.instantiate()
	add_child(minigame)


func _on_game_manager_game_started():
	print("game started")
	if Dialogic.current_timeline != null:
		return
	Dialogic.start('timeline')
	get_viewport().set_input_as_handled()
	Dialogic.timeline_ended.connect(_on_time_line_ended)

	

func _on_time_line_ended():
	print("mini_game")
	start_minigame()













