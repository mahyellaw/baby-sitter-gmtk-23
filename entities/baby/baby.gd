extends Area2D

@export var parent_sheets : Array[Texture]

const SPEED = 100.0

var carrying_parent = false

@onready var destination = global_position

func _ready():
	$HeldParent.texture = parent_sheets[SignalBus.gender]

func _input(_event):
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		destination = get_global_mouse_position()

func _process(delta):
	var x_dist = destination.x - position.x
	$Texture.flip_h = true if x_dist > 0 else false
	
	if position.distance_to(destination) > 10:
		position.x = move_toward(position.x, destination.x, SPEED * delta)

func _on_area_entered(area):
	if area.name == "Parent":
		$HeldParent.show()
		carrying_parent = true

func release_parent():
	$HeldParent.hide()
	carrying_parent = false
