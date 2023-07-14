extends Area2D

signal parent_interacted

@export var parent_scene : PackedScene
@export var parent_sheets : Array[Texture]

@export_enum("Doorway", "Fridge", "Sofa", "TV", "CigAndTray") var workstation_type
@export var workstation_textures : Array[Texture]

var button_texts = [
	"Work",
	"Eat",
	"Sleep",
	"Watch",
	"Smoke"
]

var corresponding_status = {
	"Hunger": 100,
	"Energy": 100,
	"Stress": -randf_range(15.0, 30.0),
	"Health": -randf_range(15.0, 30.0)
}

var occupied = false

var wage = randf_range(150.0, 250.0)

func _ready():
	connect("parent_interacted", Callable(SignalBus, "_on_parent_interact"))
	
	$Texture.texture = workstation_textures[workstation_type]
	get_children()[workstation_type + 1].show()
	$Button.text = button_texts[workstation_type]
	for sprite in $InteractionPoints.get_children():
		sprite.texture = parent_sheets[SignalBus.gender]

func _on_mouse_entered():
	if not occupied:
		$Button.show()
func _on_mouse_exited():
	$Button.hide()

func _on_button_pressed():
	var dist_to_baby = global_position.distance_to(%Baby.global_position)
	
	if dist_to_baby > 30:
		%Prompt.trigger_distance_event()
	
	if %Baby.carrying_parent and dist_to_baby < 30:
		if %ProductivityPoints.points < 60 and workstation_type == 0:
			%Prompt.trigger_points_event()
			return
		occupied = true
		%Baby.release_parent()
		$Button.hide()
		if workstation_type != 0:
			$InteractionPoints.get_child(workstation_type - 1).show()
		$ActionCooldown.start()

func _on_action_cooldown_timeout():
	$InteractionPoints.get_child(workstation_type - 1).hide()
	if workstation_type == 0:
		emit_signal("parent_interacted", corresponding_status.keys()[2], randf_range(15.0, 30.0))
		emit_signal("parent_interacted", corresponding_status.keys()[1], -randf_range(15.0, 30.0))
		%Money.money_amount += wage
	else:
		emit_signal("parent_interacted", corresponding_status.keys()[workstation_type - 1], corresponding_status[ corresponding_status.keys()[workstation_type - 1] ])
		if workstation_type == 1:
			emit_signal("parent_interacted", corresponding_status.keys()[3], randf_range(15.0, 30.0))
		
		if workstation_type == 4:
			emit_signal("parent_interacted", corresponding_status.keys()[2], -100)
	return_parent()

func return_parent():
	var p = parent_scene.instantiate()
	p.position = Vector2(randf_range(600, 696), 408)
	get_parent().add_child(p)
	occupied = false
