extends Area2D

var SPEED = 200
var damage = 1
var velocity = Vector2()
var direction = Global.direction.moveRight
var x_pos = 0
var atk_range = 0

func _ready():
	pass
	
func setAtkRange(atkRange):
	atk_range = atkRange
	
func setInitialPosition(x_position):
	x_pos = x_position
	
func setBulletDirection(dir):
	direction = dir
	if dir == Global.direction.moveLeft:
		$Sprite.flip_h = true
		
func setBulletSpeed(speed):
	SPEED = speed
	
func setBulletDamage(dam):
	damage = dam
	
func _physics_process(delta):
	velocity.x = SPEED * delta * direction
	translate(velocity)
	if abs(x_pos - position.x) > atk_range:
		queue_free()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free() 

func _on_EnemyBullet_body_entered(body):
	if "player" in body.name:
		body.take_damage(damage)
	if "player" in body.name or "Background" or "Level" or "TileMap" in body.name:
		queue_free()
	
