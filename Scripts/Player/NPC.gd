extends KinematicBody2D

const GRAVITY = 10
const SPEED = 30
const FLOOR = Vector2(0, -1)

var velocity = Vector2()
var direction = Global.direction.moveRight

var playerOnConnect = false
var shopOpened = false

func _ready():
	$NPCArea2D.connect("area_entered", self, "playerEntered")
	$NPCArea2D.connect("area_exited", self, "playerExited")

func _physics_process(delta):
	velocity.x = 0 if playerOnConnect else SPEED * direction
	
	velocity.y += GRAVITY
	
	$AnimatedSprite.flip_h = !direction == Global.direction.moveRight
	
	if playerOnConnect:
		$AnimatedSprite.play("idle")
	else:
		$AnimatedSprite.play("walk")
	
	velocity = move_and_slide(velocity, FLOOR)
	
	if is_on_wall() or !$RayCast2D.is_colliding():
		direction = -direction
		$RayCast2D.position.x *= -1

func _input(event):
	if playerOnConnect and Input.is_action_pressed("ui_accept") and !shopOpened:
		shopOpened = true
		print("Open Shop")
	elif playerOnConnect and Input.is_action_pressed("ui_cancel") and shopOpened:
		shopOpened = false
		print("Close Shop")
		
func playerEntered(object):
	playerOnConnect = object.get_name() == "PlayerArea2D"
	
func playerExited(object):
	if object.get_name() == "PlayerArea2D":
		playerOnConnect = false
		shopOpened = false