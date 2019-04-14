extends Area2D

const SPEED = 200
var velocity = Vector2()
var direction = 1


func _ready():
	pass
	
func set_fireball_direction(dir):
	direction = dir
	if dir == -1:
		$Sprite.flip_h = true
	pass
	
func _physics_process(delta):
	velocity.x = SPEED * delta * direction
	translate(velocity)
	pass

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
	pass 


func _on_fireball_body_entered(body):
	queue_free()
	pass
