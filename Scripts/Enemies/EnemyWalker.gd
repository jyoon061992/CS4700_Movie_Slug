extends KinematicBody2D

export var gravity = 10
export var speed = 30
export var health = 1
export var ledgeDetection = false

const FLOOR = Vector2(0, -1)

var velocity = Vector2()
var direction = Global.direction.moveRight

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func _physics_process(delta):
	velocity.x = speed * direction
	velocity.y += gravity
	
	if direction == Global.direction.moveRight:
		$AnimatedSprite.flip_h = false
	else:
		$AnimatedSprite.flip_h = true
		
	$AnimatedSprite.play("walk")
	
	velocity = move_and_slide(velocity, FLOOR)
	
	if is_on_wall() || $RayCast2D.is_colliding() == false && ledgeDetection == true:
		# flip the direction
		direction = direction * -1
		$RayCast2D.position.x *= -1