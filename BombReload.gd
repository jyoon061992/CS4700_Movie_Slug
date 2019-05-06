extends Area2D

export var amount = 3

func _on_BombReload_body_entered(body):
	
	if "player" in body.name:
		print("entered")
		body.reload_bomb(amount)
		queue_free()
	pass # Replace with function body.
