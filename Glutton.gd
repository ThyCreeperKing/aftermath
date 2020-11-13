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
var dieonce = false


###SIGNALS###
signal attack
signal dead


###GLUTTON LOOP###
func _physics_process(_delta):
	#Glutton Chase Mechanics
	velocity.x = 0
	if player and dieonce == false:
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
	if health <= 0 and dieonce == false:
		velocity.x = 0
		dieonce = true
		emit_signal("dead")
	
	#Gravity and Movement
	velocity = move_and_slide(velocity,Vector2.UP)
	velocity.y += GRAVITY



#Hit by Bullet
func _on_HitArea_area_entered(area):
	#LIFE OR DEATH!
	if health > 0:
		#Hurt Sound
		var hurtsound = randi()%3+1
		if hurtsound == 1:
			$SoundHurt.play()
		elif hurtsound == 2:
			$SoundHurt2.play()
		elif hurtsound == 3:
			$SoundHurt3.play()
		
		health -= randi()%4+3
		area.queue_free()
		$GluttonSprite.modulate = Color(1,0,0,1)
		yield(get_tree().create_timer(0.15), "timeout")
		$GluttonSprite.modulate = Color(1,1,1,1)
	
	elif health <= 0:
		area.queue_free()
		emit_signal("dead")

#When Animation Finished
func _on_GluttonSprite_animation_finished():
	if $GluttonSprite.animation == "Jump":
		$GluttonSprite.stop("Jump")
	if $GluttonSprite.animation == "Attack" and dieonce == false:
		emit_signal("attack")


#Player Detection
func _on_Visibility_body_entered(body):
	if dieonce == false:
		player = body
	
		#Anger Sound
		var angersound = randi()%3+1
		if angersound == 1:
			$SoundAnger.play()
		elif angersound == 2:
			$SoundAnger2.play()
		elif angersound == 3:
			$SoundAnger3.play()

func _on_Visibility_body_exited(_body):
	player = null


#Attack Range Detection
func _on_AttackRange_body_entered(body):
	attack_detection = body
func _on_AttackRange_body_exited(_body):
	attack_detection = null


func _on_Glutton_dead():
	$GluttonSprite.play("Death")
	yield($GluttonSprite, "animation_finished")
	queue_free()
