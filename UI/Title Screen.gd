extends Node


func _ready():
	pass 



func _on_Button_pressed():
	get_tree().change_scene("res://Scenes/Levels/OpeningLevel.tscn")
	pass

func _on_Button3_pressed():
	get_tree().change_scene("res://UI/CreditsScreen.tscn")
	pass 

func _on_Button2_pressed():
	get_tree().change_scene("res://UI/ControlScreen.tscn")