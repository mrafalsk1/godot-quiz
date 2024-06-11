extends Control
const File = preload("res://Scripts/file.gd")
const RANKS_FILE_PATH = "res://Database/Ranks.json"
# Called when the node enters the scene tree for the first time.
func _ready():
	var file_manager = File.new()
	var content = file_manager.read_file(RANKS_FILE_PATH)
	print(content)
	for i in content.keys():
		print(i)
		print(content[i])
	pass # Replace with function body.
	
