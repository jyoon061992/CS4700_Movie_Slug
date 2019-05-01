extends Sprite

onready var animation = get_node("AnimationPlayer")
var damage = 10
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	animation.play("explode")
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_AnimationPlayer_animation_finished(anim_name):
	queue_free()


func _on_Area2D_body_entered(body):
	if "Enemy" in body.name:
		body.decreaseHealth(damage)
