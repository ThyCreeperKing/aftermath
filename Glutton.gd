extends KinematicBody2D

###VARIABLE SETUP###
const MOVE_SPEED = 75
const GRAVITY = 19.6
const JUMP_SPEED = -250
var velocity = Vector2(0,0)
var player = null

#Damage Signal
signal damage
func _on_DamageArea_body_entered(_body):
	emit_signal("damage")
	queue_free()

#Player Detection
func _on_Visibility_body_entered(body):
	player = body

func _on_Visibility_body_exited(body):
	player = null


###ENEMY LOOP###
func _physics_process(delta):
	#Player Chase
	velocity.x = 0
	if player:
		if player.position.x > position.x:
			velocity.x = MOVE_SPEED
			$GluttonSprite.flip_h = false
		
		elif player.position.x < position.x:
			velocity.x = -MOVE_SPEED
			$GluttonSprite.flip_h = true
	
	#Gravity and Movement
	velocity = move_and_slide(velocity,Vector2.UP)
	velocity.y += GRAVITY

	
	
