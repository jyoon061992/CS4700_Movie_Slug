extends KinematicBody2D

const GRAVITY = 10
const SPEED = 30
const FLOOR = Vector2(0, -1)

var velocity = Vector2()
var direction = Global.direction.moveRight

func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	velocity.x = SPEED * direction
	
	velocity.y += GRAVITY
	
	$AnimatedSprite.flip_h = !direction == Global.direction.moveRight
	
	$AnimatedSprite.play("walk")
	
	velocity = move_and_slide(velocity, FLOOR)
	
	if is_on_wall() or !$RayCast2D.is_colliding():
		direction = -direction
		$RayCast2D.position.x *= -1