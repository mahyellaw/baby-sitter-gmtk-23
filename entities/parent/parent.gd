extends Area2D

@export var parent_sheets : Array[Texture]

func _ready():
	$Texture.texture = parent_sheets[SignalBus.gender]

func _on_area_entered(area):
	if area.name == "Baby":
		call_deferred("queue_free")
