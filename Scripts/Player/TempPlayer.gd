extends KinematicBody2D

const SPEED = 60
const GRAVITY = 10
const JUMP_POWER = -250
const FLOOR = Vector2(0, -1)

var velocity = Vector2()


func _physics_process(delta):
	handle_movement(SPEED)
	
	velocity.y += GRAVITY
	
	velocity = move_and_slide(velocity, FLOOR)

func handle_movement(speed):
	velocity.x = (speed if Input.is_action_pressed("ui_right") else (-speed if Input.is_action_pressed("ui_left") else 0))
	velocity.y = (JUMP_POWER if Input.is_action_pressed("ui_up") && is_on_floor() else velocity.y)