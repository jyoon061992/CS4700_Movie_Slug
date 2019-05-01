extends Area2D

const inchealth = 30

func _on_powerUp_body_entered(body):
	if "player" in body.name:
		body.inc_health(30)
		queue_free()
