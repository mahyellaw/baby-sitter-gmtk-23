extends Control

signal quota_reached

var money_amount = 0.0
var quota = 1500

func _ready():
	connect("quota_reached", Callable(SignalBus, "_on_money_quota_reach"))

func _process(delta):
	if money_amount >= quota:
		emit_signal("quota_reached")
	$Value.text = "%2.2f" % money_amount
