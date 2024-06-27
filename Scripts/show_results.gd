extends Control

@onready var label = $Label
@onready var descricao = $descricao


func _ready():
	descricao.text = "A sua pontuação para a eletiva " + str(Dialogic.VAR.elective) + " foi:"
	label.text = str(Game.score)


func _on_game_manager_end_quiz():
	print("end quiz")
	pass # Replace with function body.


func _on_continue_button_pressed():
	Game.save_score(Dialogic.VAR.elective)	
	Dialogic.signal_event.emit("next_quiz")

