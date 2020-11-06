extends KinematicBody2D

###VARIABLE SETUP###
const MOVE_SPEED = 75
const GRAVITY = 19.6
const JUMP_SPEED = -275
var velocity = Vector2(0,0)
var player = null


###SIGNALS###
signal attack

###GLUTTON LOOP###
func _physics_process(_delta):
	#Player Chase & Attack Mechanics
	velocity.x = 0
	if player:
		if player.position.x > position.x + 50:
			velocity.x = MOVE_SPEED
			$GluttonSprite.flip_h = false
			
			if player.position.x <= position.x + 51:
				$GluttonSprite.play("Attack")
				print("attack right")
			
		elif player.position.x < position.x - 50:
			velocity.x = -MOVE_SPEED
			$GluttonSprite.flip_h = true
			
			if player.position.x >= position.x - 49:
				$GluttonSprite.play("Attack")
				print("attack left")
	
	#Gravity and Movement
	velocity = move_and_slide(velocity,Vector2.UP)
	velocity.y += GRAVITY
	
	#Idle
	if velocity == Vector2(0,19.6) and player == null:
		$GluttonSprite.play("Idle")
	
	#Jump Mechanics
	if is_on_wall():
		velocity.y = JUMP_SPEED
		$GluttonSprite.play("Jump")
	
	#Max Health
	if Global.glutton_health > 20:
		Global.glutton_health = 20
	#Death
	elif Global.glutton_health <= 0:
		$GluttonSprite.play("Death")


#Player Detection
func _on_Visibility_body_entered(body):
	player = body
func _on_Visibility_body_exited(_body):
	player = null


#Checking for Finished Animations
func _on_GluttonSprite_animation_finished():
	#Jump Once
	if $GluttonSprite.animation == "Jump":
		$GluttonSprite.stop()
	#Attack Signal
	if $GluttonSprite.animation == "Attack":
		emit_signal("attack")
	#Death
	if $GluttonSprite.animation == "Death":
		queue_free()


#Hit by Bullet
func _on_DamageArea_area_entered(area):
	Global.glutton_health -= randi()%4+3
	area.queue_free()

