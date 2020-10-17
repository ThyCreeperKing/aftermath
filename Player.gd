extends KinematicBody2D


###VARIABLE SETUP###
const MOVE_SPEED = 275
const GRAVITY = 19.6
const JUMP_SPEED = -425
var velocity = Vector2(0,0)
var ammo = 0
var health = 20


###PLAYER LOOP###
func _physics_process(_delta):
	
	#Input Control
	if Input.is_action_pressed("move_left"):
		velocity.x = -MOVE_SPEED
		$PlayerSprite.play("Walk")
		$PlayerSprite.flip_h = true
	
	elif Input.is_action_pressed("move_right"):
		velocity.x = MOVE_SPEED
		$PlayerSprite.play("Walk")
		$PlayerSprite.flip_h = false
	
	elif velocity.x == 0 and velocity.y == 0:
		$PlayerSprite.play("Idle")
	
	else: 
		velocity.x = 0
	
	#Jump Control
	if Input.is_action_pressed("jump") and is_on_floor():
		velocity.y = JUMP_SPEED

	elif velocity.y  < 0:
		$PlayerSprite.play("Jump")
	
	elif velocity.y > 100:
		$PlayerSprite.play("Fall")
	
	#Crouch Contrtol
	if Input.is_action_pressed("crouch") and is_on_floor():
		velocity.x = 0
		velocity.y = 0
		$PlayerSprite.play("Crouch")
	
	#Gravity and Movement
	velocity.y += GRAVITY
	velocity = move_and_slide(velocity,Vector2.UP)
	
	#Death
	if health <= 0:
		get_tree().change_scene("res://World.tscn")



###PICKUPS###
#Ammo Pickup
func _on_Ammo_collected():
	ammo = ammo + 1
	
#MRE Pickup
func _on_MRE_collected():
	health = health + 3
