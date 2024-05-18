

class_name Elective
var question: String
var options: Array
var correct_option_index: int

#func _init(q: String, o: Array[String], coi: int):
	#print(q)
	#question = q
	#options = o
	#correct_option_index = coi


const ELECTIVE_NAMES = {
	"MATHEMATICS": "Matemática",
	"PORTUGUESE": "Português"
}


static func get_elective_questions(elective: String, parent_elective) -> Array[Elective]:
	var json_string = FileAccess.get_file_as_string("res://Database/Questions.json")
	var questions = JSON.parse_string(json_string)
	var elective_questions: Array[Elective]
	for i in questions[parent_elective][elective]:
		var e = Elective.new()
		e.question = i["question"]
		e.options = i["options"]
		e.correct_option_index = i["correct_option_index"]
		elective_questions.append(e)
	return elective_questions
	

	
