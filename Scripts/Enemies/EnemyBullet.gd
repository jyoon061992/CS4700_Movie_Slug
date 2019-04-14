extends Area2D

export var SPEED = 200
export var damage = 1
var velocity = Vector2()
var direction = Global.direction.moveRight

func _ready():
	pass
	
func setBulletDirection(dir):
	direction = dir
	if dir == Global.direction.moveLeft:
		$AnimatedSprite.flip_h = true
	
func _physics_process(delta):
	velocity.x = SPEED * delta * direction
	translate(velocity)

func _on_VisibilityNotifier2D_screen_exited():
	queue_free() 

func _on_EnemyBullet_body_entered(body):
	if "player" in body.name:
		body.take_damage(damage)
	
	queue_free()
