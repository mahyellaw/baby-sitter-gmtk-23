extends Control

var points = 0

func _process(_delta):
	points = (%ParentStatus.health_status + %ParentStatus.energy_status) / 2
	$Value.text = "%02d" % points
