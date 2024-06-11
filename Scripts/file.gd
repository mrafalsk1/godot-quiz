extends Node

var json = JSON.new()

func read_file(path: String):
	# var file = FileAccess.open("res://Database/Questions.json", FileAccess.READ)
	var file = FileAccess.open(path, FileAccess.READ)
	print(file)
	print(file.get_as_text())
	return json.parse_string(file.get_as_text())

func save_file(path: String, content: Variant):
	var file = FileAccess.open(path,FileAccess.WRITE)
	file.store_string(json.stringify(content))
	file.close()
	file = null
	
