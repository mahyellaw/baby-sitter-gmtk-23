extends Node

var parent_status_object = null

var win_status = false
var gender = 0

func _on_parent_interact(status_name, value):
	if value > 0:
		parent_status_object.increase_status(status_name, value)
	else:
		parent_status_object.decrease_status(status_name, abs(value))

func _on_money_quota_reach():
	win_status = true
	get_tree().change_scene_to_file("res://game-scenes/game-screens/game_screen.tscn")
