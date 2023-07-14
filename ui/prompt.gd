extends Label


func trigger_points_event():
	show()
	text = "Need more points."
	$AnimationPlayer.play("fade_up")

func trigger_distance_event():
	show()
	text = "Too far."
	$AnimationPlayer.play("fade_up")
