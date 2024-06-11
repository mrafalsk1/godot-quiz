
class_name Elective
var question: String
var options: Array
var correct_option_index: int

#func _init(q: String, o: Array[String], coi: int):
	#print(q)
	#question = q
	#options = o
	#correct_option_index = coi

const File = preload("res://Scripts/file.gd")
const ELECTIVE_NAMES = {
	"MATHEMATICS": "Matemática",
	"PORTUGUESE": "Português"
}


static func get_elective_questions(elective: String, parent_elective) -> Array[Elective]:
	#var json = JSON.new()
	#var file = FileAccess.open("res://Database/Questions.json", FileAccess.READ)
	#print(file)
	#print(file.get_as_text())
	#var questions = json.parse_string(file.get_as_text())
	var file_manager = File.new()
	var questions = file_manager.read_file("res://Database/Questions.json")
	var elective_questions: Array[Elective]
	for i in questions[parent_elective][elective]:
		var e = Elective.new()
		e.question = i["question"]
		e.options = i["options"]
		e.correct_option_index = i["correct_option_index"]
		elective_questions.append(e)
	return elective_questions
	

	
