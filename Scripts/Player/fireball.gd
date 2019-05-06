extends Area2D

export var SPEED = 200
export var damage = 1
var velocity = Vector2()
var direction = Global.direction.moveRight

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
	# Naming convetion for enemies was ignored so this had to be added in
	if "bomber" in body.name or "shooter" in body.name or "walker" in body.name or "Enemy" in body.name: 
		body.decreaseHealth(damage)
		
	if !"Coin" in body.name:
		queue_free()
		
	pass
