extends KinematicBody2D

###VARIABLE SETUP###
const MOVE_SPEED = 100
const GRAVITY = 19.6
const JUMP_SPEED = -300
var velocity = Vector2(0,0)
var direction = true


#Damage Signal
signal damage
func _on_DamageArea_body_entered(body):
	emit_signal("damage")
	queue_free()

###ENEMY LOOP###
func _physics_process(delta):
	#Movement
	velocity = move_and_slide(velocity)
	if direction == true:
		velocity.x = MOVE_SPEED
		$AnimatedSprite.play("walk")
	elif direction == false:
		velocity.x = -MOVE_SPEED
	
	velocity.y += GRAVITY
