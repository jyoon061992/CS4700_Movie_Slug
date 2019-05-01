extends Node


func _ready():
	pass 


func _on_LinkButton_pressed():
	OS.shell_open("https://matias.ma/nsfw/")
	pass 


func _on_Button_pressed():
	get_tree().change_scene("res://Scenes/Levels/HubWorld.tscn")
	pass
