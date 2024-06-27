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

func _ready():
	var file_manager = File.new()
	var content = file_manager.read_file(RANKS_FILE_PATH)
	print(content)
	for i in content.keys():
		print(i)
		print(content[i])
	pass # Replace with function body.
	
