extends Control

@onready var label = $Panel2/Label
@onready var descricao = $Panel2/HBoxContainer/descricao

const ELECTIVE_NAMES = {
	"iniciacao_cientifica": "Iniciação Científica",
	"ciencias_humanas_sociais": "Ciências Humanas e Sociais",
	"ciencias_natureza": "Ciências da Natureza e Suas Tecnologias",
	"linguagens_tecnologias": "Linguagens e Suas Tecnologias",
	"matematica_tecnologias": "Matemática e Suas Tecnologias"
}


func _ready():
	descricao.text = "A sua pontuação para a eletiva " + str(ELECTIVE_NAMES[Dialogic.VAR.elective]) + " foi:"
	label.text = str(Game.score)
	Dialogic.VAR.count_elective = str(int(Dialogic.VAR.count_elective) + 1)


func _on_game_manager_end_quiz():
	print("end quiz")
	pass # Replace with function body.


func _on_continue_button_pressed():
	Game.save_score(Dialogic.VAR.elective)	
	print(Dialogic.VAR.count_elective)
	Dialogic.signal_event.emit("next_quiz")
	

