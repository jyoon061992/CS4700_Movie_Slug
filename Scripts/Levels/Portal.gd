extends Area2D


func _ready():
	pass 


	
func _on_Portal_body_entered(body):
	if "player" in body.name:
	 get_tree().change_scene("res://Scenes/Levels/TestingGround.tscn")
	pass 
