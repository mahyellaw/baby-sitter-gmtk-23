extends Control

const DEDUCT_SPEED = 0.025

var health_status = 0
var energy_status = 0

func _ready():
	SignalBus.parent_status_object = self

func _process(_delta):
	decrease_status("Hunger", DEDUCT_SPEED)
	decrease_status("Energy", DEDUCT_SPEED)
	
	if $MarginContainer/HBoxContainer/Hunger/TextureProgressBar.value <= 0:
		decrease_status("Health", DEDUCT_SPEED)
	
	health_status = $MarginContainer/HBoxContainer/Health/TextureProgressBar.value
	energy_status = $MarginContainer/HBoxContainer/Energy/TextureProgressBar.value
	
	if health_status <= 0 or $MarginContainer/HBoxContainer/Stress/TextureProgressBar.value >= 100:
		SignalBus.win_status = false
		get_tree().change_scene_to_file("res://game-scenes/game-screens/game_screen.tscn")

func increase_status(status_name, value = 100):
	get_node("MarginContainer/HBoxContainer/%s/TextureProgressBar" % status_name).value += value

func decrease_status(status_name, value = randf_range(15.0, 30.0)):
	get_node("MarginContainer/HBoxContainer/%s/TextureProgressBar" % status_name).value -= value
