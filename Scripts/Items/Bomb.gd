extends RigidBody2D

onready var explosionScene = preload("res://Scenes/Etc/Explosion.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Timer_timeout():
	explode()

func explode():
	var explosion = explosionScene.instance()
	get_parent().add_child(explosion)
	self.queue_free()
	explosion.position = self.position