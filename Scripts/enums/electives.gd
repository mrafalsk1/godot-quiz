
class_name Elective
var question: String
var options: Array
var correct_option_index: int

const File = preload("res://Scripts/file.gd")


static func get_elective_questions(elective: String) -> Array[Elective]:
	var file_manager = File.new()
	var questions = file_manager.read_file("res://Database/Questions.json")
	var elective_questions: Array[Elective]
	for i in questions[elective]:
		var e = Elective.new()
		e.question = i["question"]
		e.options = i["options"]
		e.correct_option_index = i["correct_option_index"]
		elective_questions.append(e)
	return elective_questions
	

	
