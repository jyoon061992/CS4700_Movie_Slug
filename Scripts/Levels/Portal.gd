extends Area2D

export var level_to_teleport_to : String = "TestingGround"

var inBody: bool = false

func _ready():
	pass 

func _input(event):
	if inBody and Input.is_action_just_pressed("ui_accept"):
		get_tree().change_scene("res://Scenes/Levels/"+level_to_teleport_to+".tscn")
	
func _on_Portal_body_entered(body):
	if "player" in body.name:
		inBody = true
	pass 


func _on_Portal_body_exited(body):
	if "player" in body.name:
		inBody = false
	pass