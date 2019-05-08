extends RigidBody2D

export var amount = 100

func _on_Area2D_body_entered(body):
	if "player" in body.name:
		print("entered")
		body.inc_health(amount)
		queue_free()
	pass
