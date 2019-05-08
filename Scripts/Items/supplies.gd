extends RigidBody2D

export var amount = 100
var type = "coin"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_Area2D_body_entered(body):
	if "player" in body.name:
		body.reload(amount)
		queue_free()