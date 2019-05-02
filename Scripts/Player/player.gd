extends KinematicBody2D

const SPEED = 60
const GRAVITY = 10
const JUMP_POWER = -250
const JUMP_COUNTER = 1
const SHOT_COUNTER = 1
const FLOOR = Vector2(0,-1)

const FIREBALL = preload("res://Scenes/Player/fireball.tscn")
const BOMB = preload("res://Scenes/Items/Bomb.tscn")

export var Camera_Constraint_Right = 100000
export var Camera_Constraint_Up = 100000

var velocity = Vector2()
var on_ground = false
var out_of_energy = false
var out_of_bombs = false

var jump_count = 0

export var max_health = 100
export var max_energy = 100
export var starting_coins = 0
export var can_shoot = true
export var god_mode = false;

var coins = starting_coins
var health = max_health
var shot = max_energy
var shot_cost = 5
var reload_amount = 3
var dead = false
var bomb = 3
var sprint = false

# When the character dies, we fade the UI
enum STATES {ALIVE, DEAD}
var state = STATES.ALIVE

signal health_changed
signal died
signal shooting
signal emerald
signal bomb

func _ready():
	get_node("Camera2D").limit_right = Camera_Constraint_Right
	pass

func _physics_process(delta):
	if dead == true:
		return
	
	# S Button
	if Input.is_action_just_pressed("ui_page_down"):
		if out_of_bombs:
			return
		drop_bombs()
		pass
	
	# A Button
	if Input.is_action_pressed("ui_page_up"):
		sprint = true
	else:
		sprint = false
	
	# D Button
	if Input.is_action_just_pressed("ui_home"):
		reload(reload_amount)
		pass

	if Input.is_action_pressed("ui_right"):
		if sprint:
			velocity.x = SPEED*2
			run()
		else:
			velocity.x = SPEED
		$AnimatedSprite.flip_h = false
		$AnimatedSprite.play("walk")
		if sign($Position2D.position.x) == -1:
			$Position2D.position *= -1
	elif Input.is_action_pressed("ui_left"):
		if sprint:
			velocity.x = -SPEED*2
			run()
		else:
			velocity.x = -SPEED
		$AnimatedSprite.flip_h = true
		$AnimatedSprite.play("walk")
		if sign($Position2D.position.x) == 1:
			$Position2D.position *= -1
	else:
		velocity.x = 0
		$AnimatedSprite.play("idle")
		
	if Input.is_action_just_pressed("ui_up"):
#		if on_ground == true:
#			$AnimatedSprite.play("jump")
#			velocity.y = JUMP_POWER
#			on_ground = false
		if jump_count < JUMP_COUNTER:
			jump_count+=1
			velocity.y=JUMP_POWER
			on_ground = false
		

	if Input.is_action_just_pressed("ui_accept") and can_shoot:
		if out_of_energy:
			return
		for i in SHOT_COUNTER:
			var fireball = FIREBALL.instance()
			if sign($Position2D.position.x) == 1:
				fireball.set_fireball_direction(1)
			else:
				fireball.set_fireball_direction(-1)
			get_parent().add_child(fireball)
			fireball.position = $Position2D.global_position
			yield(get_tree().create_timer(.1), "timeout")
		shoot()
		
	velocity.y += GRAVITY
	
	if is_on_floor():
		on_ground = true
		jump_count=0
	else:
		on_ground = false
		
	velocity = move_and_slide(velocity,FLOOR)
	
	if get_slide_count() > 0:
		for i in range(get_slide_count()):
			if "EnemyWalker" in get_slide_collision(i).collider.name:
				#take_damage(1)
				break
	pass

	
func take_damage(count):
	if state == STATES.DEAD:
		dead()
		return
	if god_mode:
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

func reload(amount):
	if shot < 100:
		shot+=amount
	if shot >= shot_cost*SHOT_COUNTER:
		out_of_energy = false
	emit_signal("shooting",shot)
	
func shoot():
	if shot < shot_cost*SHOT_COUNTER:
		out_of_energy = true
	else:
		shot -= shot_cost*SHOT_COUNTER
		if shot < shot_cost*SHOT_COUNTER:
			out_of_energy = true
	emit_signal("shooting",shot)
	pass
	
func run():
	if shot < shot_cost*SHOT_COUNTER:
		out_of_energy = true
	else:
		shot -= .1
		emit_signal("shooting",shot)
	pass
	
	
	
# Returns true so coin can be cleared in Coin script
func add_coins(amount):
	coins += amount
	emit_signal("emerald",coins)
	return true
	
func drop_bombs():
	var dropBomb = BOMB.instance()
	bomb -= 1
	if bomb <=0:
		out_of_bombs = true
	emit_signal("bomb",bomb)
	dropBomb.position = $Position2D.global_position
	get_parent().add_child(dropBomb)
	pass
	
func inc_health(amount):
	if health < 100:
		health += amount
		emit_signal("health_changed", health)
		

func _on_Area2D_body_entered(body):
	if "shooter" in body.name or "walker" in body.name:
		take_damage(10)
	if "bomber" in body.name:
		take_damage(40)
	pass
