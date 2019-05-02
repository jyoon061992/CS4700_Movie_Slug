extends KinematicBody2D

export var gravity = 10
export var speed = 30
export var health = 3
export var shotDelay = 1
export var lineOfSightDistance = 60
export var atk_range = 150
export var atkDamage = 1
export var bulletSpeed = 200
export var ledgeDetection = true
export var removeCorpse = true
export var shooter = false
export var bomber = false


const FLOOR = Vector2(0, -1)
const BULLET = preload("res://Scenes/Enemies/EnemyBullet.tscn")
const COIN = preload("res://Scenes/Items/Coin.tscn")
const EXPLOSION_SCENE = preload("res://Scenes/Etc/Explosion.tscn")
const SUPPLIES = preload("res://Scenes/Items/supplies.tscn")
const HEALTH = preload("res://Scenes/Items/healthUp.tscn")

var velocity = Vector2()
var direction = Global.direction.moveRight
var isDead = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$"Line of sight".add_exception($CollisionShape2D)
	$"Line of sight".set_cast_to(Vector2(0, lineOfSightDistance))
	$"Shot delay".set_wait_time(shotDelay)

func dead():
	isDead = true
	velocity = Vector2(0, 0)
	$AnimatedSprite.play("dead")
	$CollisionShape2D.call_deferred("set_disabled", true)
	dropCoin()
	var rand = randi()%4+1
	if rand == 3:
		dropSupplies()
		
	rand = randi()%11+1
	if rand == 3:
		dropHealth()
	
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
		$"Line of sight".rotate(PI)
	
	
	if $"Line of sight".is_colliding() and shooter:
		var collider = $"Line of sight".get_collider()
		# print(collider.get_class())
		if collider.get_class() == "KinematicBody2D" and $"Shot delay".time_left == 0 and !isDead:
			shoot()
	
	
	#This was Added so ememy running into player would cause damage
	#if get_slide_count() > 0:
	#	for i in range(get_slide_count()):
	#		if "player" in get_slide_collision(i).collider.name and !isDead:
	#			if bomber:
	#				explode()
	#			if !bomber:
	#				get_slide_collision(i).collider.take_damage(1)
	#			break
	#End  player damage code
	


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
	$"Shot delay".start()
	var bullet = BULLET.instance()
	bullet.setInitialPosition(position.x)
	bullet.setAtkRange(atk_range)
	bullet.setBulletSpeed(bulletSpeed)
	bullet.setBulletDamage(atkDamage)
	if sign($Position2D.position.x) == Global.direction.moveRight:
		bullet.setBulletDirection(Global.direction.moveRight)
	else:
		bullet.setBulletDirection(Global.direction.moveLeft)
		
	get_parent().add_child(bullet)
	bullet.position = $Position2D.global_position
	
func dropCoin():
	var coin = COIN.instance()
	get_parent().add_child(coin)
	coin.position = $Position2D.global_position

func dropSupplies():
	var supply = SUPPLIES.instance()
	get_parent().add_child(supply)
	supply.position = $Position2D.global_position

func dropHealth():
	var health = HEALTH.instance()
	get_parent().add_child(health)
	health.position = $Position2D.global_position

func explode():
	var explosion = EXPLOSION_SCENE.instance()
	explosion.isEnemy()
	get_parent().add_child(explosion)
	self.queue_free()
	isDead = true
	explosion.position = self.position


func _on_Area2D_body_entered(body):
	if "player" in body.name:
		explode()
	pass 
