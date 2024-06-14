extends Control
const RANK = preload("res://Scenes/rank.tscn")


func _on_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/game.tscn")


func _on_rank_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/rank.tscn")
