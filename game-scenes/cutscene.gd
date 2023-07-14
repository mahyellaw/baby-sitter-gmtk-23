extends Control

func _ready():
	if SignalBus.gender == 0:
		$AnimationPlayer.play("mom_scene")
	else:
		$AnimationPlayer.play("dad_scene")

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "mom_scene" or anim_name == "dad_scene":
		$AnimationPlayer.play("fade")
	else:
		get_tree().change_scene_to_file("res://game-scenes/apartment.tscn")
