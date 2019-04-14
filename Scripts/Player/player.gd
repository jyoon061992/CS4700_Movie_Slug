extends KinematicBody2D

const SPEED = 60
const GRAVITY = 10
const JUMP_POWER = -250
const FLOOR = Vector2(0,-1)

const FIREBALL = preload("res://Scenes/Player/fireball.tscn")

var velocity = Vector2()
var on_ground = false

export var max_health = 10
var health = max_health

# When the character dies, we fade the UI
enum STATES {ALIVE, DEAD}
var state = STATES.ALIVE

signal health_changed
signal died

func _physics_process(delta):
	if Input.is_action_pressed("ui_right"):
		velocity.x = SPEED
		$Sprite.flip_h = false
		if sign($Position2D.position.x) == -1:
			$Position2D.position *= -1
	elif Input.is_action_pressed("ui_left"):
		velocity.x = -SPEED
		$Sprite.flip_h = true
		if sign($Position2D.position.x) == 1:
			$Position2D.position *= -1
	else:
		velocity.x = 0
		
	if Input.is_action_just_pressed("ui_up"):
		if on_ground == true:
			velocity.y = JUMP_POWER
			on_ground = false
	
	if Input.is_action_just_pressed("ui_accept"):
		var fireball = FIREBALL.instance()
		if sign($Position2D.position.x) == 1:
			fireball.set_fireball_direction(1)
		else:
			fireball.set_fireball_direction(-1)
		get_parent().add_child(fireball)
		fireball.position = $Position2D.global_position
		
	velocity.y += GRAVITY
	
	if is_on_floor():
		on_ground = true
	else:
		on_ground = false
	velocity = move_and_slide(velocity,FLOOR)
	pass
	
func _on_area_enter(body):
	take_damage(1)
	print("I'm hit")
	
func take_damage(count):
	if state == STATES.DEAD:
		return

	health -= count
	if health <= 0:
		health = 0
		state = STATES.DEAD
		emit_signal("died")

	emit_signal("health_changed", health)
	
	