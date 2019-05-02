extends RigidBody2D

export var amount = 1
var type = "coin"

func _on_Area2D_body_entered(body):
	if "player" in body.name:
		if body.add_coins(amount):
			queue_free()