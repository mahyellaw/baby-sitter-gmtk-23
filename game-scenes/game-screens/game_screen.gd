extends Control


func _ready():
	if !SignalBus.win_status:
		$Lose.show()
		$ColorRect.color = Color("ff79ae")
		$Label.text = "You failed as a baby...\n
After losing the passion for the job, \nyour %s was fired, failed to pay rent\nand couldn't support you anymore." % ["mom", "dad"][SignalBus.gender]
	else:
		$Win.show()
		$ColorRect.color = Color("639bff")
		$Label.text = "Congratulations!\n
You survived potentially getting thrown on the street!\nYour %s surprisingly didn't get fired\nand therefore can continue to support their child." % ["mom", "dad"][SignalBus.gender]

func _on_button_pressed():
	get_tree().change_scene_to_file("res://game-scenes/menu.tscn")
