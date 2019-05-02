extends Area2D


func _ready():
	pass 


	
func _on_Portal_body_entered(body):
	if "player" in body.name and Input.is_action_pressed("ui_accept"):
	 get_tree().change_scene("res://Scenes/Levels/TestingGround.tscn")
	pass 
