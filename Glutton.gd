extends KinematicBody2D

###VARIABLE SETUP###
const MOVE_SPEED = 75
const GRAVITY = 19.6
const JUMP_SPEED = -275
var velocity = Vector2(0,0)
var health = 10
var player = null
var timer = null
var attack_detection = null


###SIGNALS###
signal attack


###GLUTTON LOOP###
func _physics_process(_delta):
	#Glutton Chase Mechanics
	velocity.x = 0
	if player:
		if player.position.x > position.x + 50:
			velocity.x = MOVE_SPEED
			$GluttonSprite.play("Walk")
			$GluttonSprite.flip_h = false
			
		elif player.position.x < position.x - 50:
			velocity.x = -MOVE_SPEED
			$GluttonSprite.play("Walk")
			$GluttonSprite.flip_h = true
	
	#Glutton Attack Mechanics
	if attack_detection:
		$GluttonSprite.play("Attack")
	
	#Idle
	if velocity == Vector2(0,19.6) and player == null:
		$GluttonSprite.play("Idle")
	
	#Jump Mechanics
	if is_on_wall():
		velocity.y = JUMP_SPEED
		$GluttonSprite.play("Jump")
	
	
	#Death
	elif health <= 0:
		health = 0
		velocity = Vector2(0,0)
		$GluttonSprite.stop()
		$GluttonSprite.play("Death")
		queue_free()
	
	#Gravity and Movement
	velocity = move_and_slide(velocity,Vector2.UP)
	velocity.y += GRAVITY


#When Animation Finished
func _on_GluttonSprite_animation_finished():
	if $GluttonSprite.animation == "Jump":
		$GluttonSprite.stop("Jump")
	elif $GluttonSprite.animation == "Attack":
		emit_signal("attack")


#Hit by Bullet
func _on_HitArea_area_entered(area):
	health -= randi()%4+3
	area.queue_free()
	$GluttonSprite.modulate = Color(1,0,0,1)
	yield(get_tree().create_timer(0.1), "timeout")
	$GluttonSprite.modulate = Color(1,1,1,1)


#Player Detection
func _on_Visibility_body_entered(body):
	player = body
func _on_Visibility_body_exited(_body):
	player = null


#Attack Range Detection
func _on_AttackRange_body_entered(body):
	attack_detection = body
func _on_AttackRange_body_exited(_body):
	attack_detection = null
