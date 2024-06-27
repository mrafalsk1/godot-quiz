extends Control
const File = preload("res://Scripts/file.gd")
const RANKS_FILE_PATH = "res://Database/Ranks.json"

const ELECTIVE_NAMES = {
	"iniciacao_cientifica": "Iniciação Científica",
	"ciencias_humanas_sociais": "Ciências Humanas e Sociais",
	"ciencias_natureza": "Ciências da Natureza e Suas Tecnologias",
	"linguagens_tecnologias": "Linguagens e Suas Tecnologias",
	"matematica_tecnologias": "Matemática e Suas Tecnologias"
}
@onready var electives = $Panel/electives

func _ready():
	var file_manager = File.new()
	var content = file_manager.read_file(RANKS_FILE_PATH)
	print(content)
	var electives_score = []
	for i in content.keys():
		print(i)
		print(content[i])
		electives_score.append({"elective": i, "score": content[i]})
	electives_score.sort_custom(func(a,b): return a.score > b.score)	
	var electives = electives.get_children()
	print(electives)
	for i in range(1,electives.size()):
		print(i)
		var panel = electives[i].get_child(0)
		var children = panel.get_children()
		children[0].text = ELECTIVE_NAMES[str(electives_score[i - 1].elective)]
		children[1].text = str(electives_score[i - 1].score)
		 
	pass # Replace with function body.

