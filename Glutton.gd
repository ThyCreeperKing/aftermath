extends KinematicBody2D

###VARIABLE SETUP###
const MOVE_SPEED = 75
const GRAVITY = 19.6
const JUMP_SPEED = -275
var velocity = Vector2(0,0)
var player = null


#Damage Signal
signal attack
func _on_DamageArea_body_entered(_body):
	emit_signal("attack")
	$GluttonSprite.play("Attack")


#Player Detection
func _on_Visibility_body_entered(body):
	player = body
func _on_Visibility_body_exited(_body):
	player = null


###ENEMY LOOP###
func _physics_process(_delta):
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
	
	#Idle
	if velocity == Vector2(0,19.6):
		$GluttonSprite.play("Idle")
	
	#Jump Mechanics
	if is_on_wall():
		velocity.y = JUMP_SPEED
		$GluttonSprite.play("Jump")
	
	#Health Range
	if Global.glutton_health > 20:
		Global.glutton_health = 20
	elif Global.glutton_health < 0:
		Global.glutton_health = 0
	
	#Glutton Death
	if Global.glutton_health == 0:
		queue_free()

#Glutton Damage
func _on_Bullet_gluttonshot():
	Global.glutton_health -= randi()%4+3

func _ready():
	$GluttonSprite.set_frame(0)

func _on_GluttonSprite_animation_finished():
	if $GluttonSprite.animation == "Jump":
		$GluttonSprite.stop()


