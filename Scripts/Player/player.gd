extends KinematicBody2D

const SPEED = 60
const GRAVITY = 10
const JUMP_POWER = -250
const FLOOR = Vector2(0,-1)

const FIREBALL = preload("res://Scenes/Player/fireball.tscn")
export var Camera_Constraint_Right = 100000


var velocity = Vector2()
var on_ground = false
var out_of_energy = false

export var max_health = 100
export var max_energy = 100
export var starting_coins = 10
export var can_shoot = true
var coins = starting_coins
var health = max_health
var shot = max_energy
var dead = false

# When the character dies, we fade the UI
enum STATES {ALIVE, DEAD}
var state = STATES.ALIVE

signal health_changed
signal died
signal shooting


func _ready():
	get_node("Camera2D").limit_right = Camera_Constraint_Right


func _physics_process(delta):
	if dead == true:
		return
	
	if Input.is_action_pressed("ui_right"):
		velocity.x = SPEED
		$AnimatedSprite.flip_h = false
		$AnimatedSprite.play("walk")
		if sign($Position2D.position.x) == -1:
			$Position2D.position *= -1
	elif Input.is_action_pressed("ui_left"):
		velocity.x = -SPEED
		$AnimatedSprite.flip_h = true
		$AnimatedSprite.play("walk")
		if sign($Position2D.position.x) == 1:
			$Position2D.position *= -1
	else:
		velocity.x = 0
		$AnimatedSprite.play("idle")
		
	if Input.is_action_just_pressed("ui_up"):
		if on_ground == true:
			$AnimatedSprite.play("jump")
			velocity.y = JUMP_POWER
			on_ground = false
	
	if Input.is_action_pressed("ui_down"):
		reload()

	if Input.is_action_just_pressed("ui_accept") and can_shoot:
		if out_of_energy:
			return
		var fireball = FIREBALL.instance()
		if sign($Position2D.position.x) == 1:
			fireball.set_fireball_direction(1)
		else:
			fireball.set_fireball_direction(-1)
		get_parent().add_child(fireball)
		fireball.position = $Position2D.global_position
		shoot()
		
	velocity.y += GRAVITY
	
	if is_on_floor():
		on_ground = true
	else:
		on_ground = false
	velocity = move_and_slide(velocity,FLOOR)
	
	if get_slide_count() > 0:
		for i in range(get_slide_count()):
			if "EnemyWalker" in get_slide_collision(i).collider.name:
				take_damage(1)
				break
	pass

	
func take_damage(count):
	if state == STATES.DEAD:
		dead()
		return
	health -= count
	if health <= 0:
		health = 0
		state = STATES.DEAD
		emit_signal("died")

	emit_signal("health_changed", health)
	
func dead():
	dead = true
	$AnimatedSprite.flip_v = true

func reload():
	if shot < 100:
		shot+=10
	if shot >0:
		out_of_energy = false
	emit_signal("shooting",shot)
	
func shoot():
	shot -= 10
	if shot <=0:
		out_of_energy = true
	emit_signal("shooting",shot)
	pass
	
# Returns true so coin can be cleared in Coin script
func add_coins(amount):
	coins += amount
	print("total coins: ")
	print (coins)
	
	return true