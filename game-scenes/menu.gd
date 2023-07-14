extends Control



func _on_mom_pressed():
	SignalBus.gender = 0
	get_tree().change_scene_to_file("res://game-scenes/cutscene.tscn")

func _on_dad_pressed():
	SignalBus.gender = 1
	get_tree().change_scene_to_file("res://game-scenes/cutscene.tscn")
