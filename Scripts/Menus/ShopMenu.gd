extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	hide()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _physics_process(delta):
#	pass

func _on_NPC_open_shop():
	show()
	
func _on_NPC_close_shop():
	hide()