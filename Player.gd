extends KinematicBody2D

###VARIABLE SETUP###
const MOVE_SPEED = 275
const GRAVITY = 19.6
const JUMP_SPEED = -425
var movement = Vector2(0,0)
var ammo = 0

###GAME LOOP###
func _physics_process(_delta):
	
	
	#Input Control
	if Input.is_action_pressed("move_left"):
		movement.x = -MOVE_SPEED
		$AnimatedSprite.play("Walk")
		$AnimatedSprite.flip_h = true
	
	elif Input.is_action_pressed("move_right"):
		movement.x = MOVE_SPEED
		$AnimatedSprite.play("Walk")
		$AnimatedSprite.flip_h = false
	
	elif movement.x == 0 and movement.y == 0:
		$AnimatedSprite.play("Idle")
	
	else: 
		movement.x = 0
	
	
	#Jump Control
	if Input.is_action_pressed("jump") and is_on_floor():
		movement.y = JUMP_SPEED

	elif movement.y  < 0:
		$AnimatedSprite.play("Jump")
	
	elif movement.y > 100:
		$AnimatedSprite.play("Fall")
	
	#Crouch Contrtol
	if Input.is_action_pressed("crouch") and is_on_floor():
		movement.x = 0
		movement.y = 0
		$AnimatedSprite.play("Crouch")
	
	#Gravity and Movement
	movement.y += GRAVITY
	movement = move_and_slide(movement,Vector2.UP)

#Ammo Pickup
func _on_Ammo_collected():
	ammo = ammo + 1
	print(ammo)
