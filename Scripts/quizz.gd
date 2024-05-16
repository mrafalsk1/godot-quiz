extends Control
const Electives = preload("res://Scripts/enums/electives.gd")

func _ready():
	var selected_elective: String = Dialogic.VAR.elective
	print("quiz game variavle MUTIO FODA")
	print(selected_elective)
	print(Electives.ELECTIVE_NAMES.values())
	var elective_index =  Electives.ELECTIVE_NAMES.values().find(selected_elective)
	if elective_index == -1:
		return
	
	var elective_name = Electives.ELECTIVE_NAMES.keys()[Electives.ELECTIVE_NAMES.values().find(selected_elective)]
	
	print(elective_name)
