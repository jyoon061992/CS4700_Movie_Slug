extends Node


func _ready():
	pass 



func _on_Button_pressed():
	get_tree().change_scene("res://Scenes/Levels/HubWorld.tscn")
	pass

func _on_Button3_pressed():
	OS.shell_open("https://matias.ma/nsfw/")
	pass 

func _on_Button2_pressed():
	print("These are the contorls: ")
	print("Arrow keys are to move")
	print("Space is to shoot")
	print("Hold A to sprint")
	print("Press S to drop a bomb")
	print("Spam D to reload")
	pass 
