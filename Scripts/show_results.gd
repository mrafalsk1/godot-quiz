extends Control

@onready var label = $Label


func _ready():
	label.text = str(Game.score)


func _on_game_manager_end_quiz():
	print("end quiz")
	pass # Replace with function body.
