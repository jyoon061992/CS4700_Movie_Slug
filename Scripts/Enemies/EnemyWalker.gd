extends KinematicBody2D

export var gravity = 10
export var speed = 30
export var health = 1
export var ledgeDetection = false
export var removeCorpse = false
export var shooter = false

const FLOOR = Vector2(0, -1)
const BULLET = preload("res://Scenes/Enemies/EnemyBullet.tscn")

var velocity = Vector2()
var direction = Global.direction.moveRight
var isDead = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$"Line of sight".add_exception($CollisionShape2D)

func dead():
	isDead = true
	velocity = Vector2(0, 0)
	$AnimatedSprite.play("dead")
	$CollisionShape2D.call_deferred("set_disabled", true)
	
	if removeCorpse:
		$Timer.start()

func _physics_process(delta):
	if !isDead:
		move()
		
	if is_on_wall() || !$RayCast2D.is_colliding() && ledgeDetection:
		# flip the direction
		direction = direction * -1
		$RayCast2D.position.x *= -1
		$Position2D.position.x *= -1
		$"Line of sight".position.x *= -1
	
	if $"Line of sight".is_colliding() and shooter:
		shoot()


func _on_Timer_timeout():
	queue_free()
	
func move():
	velocity.x = speed * direction
	velocity.y += gravity
	
	if direction == Global.direction.moveRight:
		$AnimatedSprite.flip_h = false
	else:
		$AnimatedSprite.flip_h = true
		
	$AnimatedSprite.play("walk")
	
	velocity = move_and_slide(velocity, FLOOR)
	
func decreaseHealth(amount):
	health -= amount;
	
	if health <= 0:
		dead()
		
func shoot():
	var bullet = BULLET.instance()
	
	if sign($Position2D.position.x) == Global.direction.moveRight:
		bullet.setBulletDirection(Global.direction.moveRight)
	else:
		bullet.setBulletDirection(Global.direction.moveLeft)
		
	get_parent().add_child(bullet)
	bullet.position = $Position2D.global_position