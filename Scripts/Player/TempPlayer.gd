extends KinematicBody2D

export var SPEED = 60
export var GRAVITY = 10
export var JUMP_POWER = -250
export var Camera_Constraint_Right = 100000
const FLOOR = Vector2(0, -1)

var velocity = Vector2()

func _ready():
	get_node("Camera2D").limit_right = Camera_Constraint_Right

func _physics_process(delta):
	handle_movement(SPEED)
	
	velocity.y += GRAVITY
	
	velocity = move_and_slide(velocity, FLOOR)

func handle_movement(speed):
	velocity.x = (speed if Input.is_action_pressed("ui_right") else (-speed if Input.is_action_pressed("ui_left") else 0))
	velocity.y = (JUMP_POWER if Input.is_action_pressed("ui_up") && is_on_floor() else velocity.y)