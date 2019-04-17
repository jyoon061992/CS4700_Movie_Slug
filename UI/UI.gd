extends MarginContainer

onready var number_label = $HBX/Bars/Health/Count/Background/Number
onready var bar = $HBX/Bars/Health/Gauge
onready var number_label_energy = $HBX/Bars/Energy/Count/Background/Number
onready var bar_energy = $HBX/Bars/Energy/Gauge
onready var tween = $Tween


var animated_health = 0
var animated_energy = 0

func _ready():
	var player_max_health = 100
	var player_max_energy = 100
	bar.max_value = player_max_health
	update_health(player_max_health)
	update_energy(player_max_energy)


func update_health(new_value):
	tween.interpolate_property(self, "animated_health", animated_health, new_value, 0.6, Tween.TRANS_LINEAR, Tween.EASE_IN)
	if not tween.is_active():
		tween.start()

func update_energy(new_value):
	tween.interpolate_property(self, "animated_energy", animated_energy, new_value, 0.6, Tween.TRANS_LINEAR, Tween.EASE_IN)
	if not tween.is_active():
		tween.start()


func _process(delta):
	var round_value = round(animated_health)
	number_label.text = str(round_value)
	bar.value = round_value
	
	round_value = round(animated_energy)
	number_label_energy.text = str(round_value)
	bar_energy.value = round_value


func _on_Player_died():
	var start_color = Color(1.0, 1.0, 1.0, 1.0)
	var end_color = Color(1.0, 1.0, 1.0, 0.0)
	tween.interpolate_property(self, "modulate", start_color, end_color, 1.0, Tween.TRANS_LINEAR, Tween.EASE_IN)


func _on_player_health_changed(player_health):
	update_health(player_health)
	pass


func _on_player_shooting(player_energy):
	update_energy(player_energy)
	pass 
