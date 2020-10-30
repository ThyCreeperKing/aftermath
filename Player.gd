extends KinematicBody2D


###VARIABLE SETUP###
const MOVE_SPEED = 275
const GRAVITY = 19.6
const JUMP_SPEED = -425
var velocity = Vector2(0,0)
var bullet = preload("res://Bullet.tscn")


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
	
	else: 
		velocity.x = 0
	
	#Jump Control
	if Input.is_action_pressed("jump") and is_on_floor():
		velocity.y = JUMP_SPEED

	elif velocity.y  < 0:
		$PlayerSprite.play("Jump")
	
	elif velocity.y > 235:
		$PlayerSprite.play("Fall")
	
	#Crouch Contrtol
	if Input.is_action_pressed("crouch") and is_on_floor():
		velocity.x = 0
		velocity.y = 0
		$PlayerSprite.play("Crouch")
	
	#Idle Animation
	if velocity == Vector2(0,0) and not $PlayerSprite.animation == "Shoot" and not $PlayerSprite.animation == "Crouch":
		$PlayerSprite.animation = "Idle"
	
	#Shooting
	if Input.is_action_just_pressed("shoot") and Global.player_ammo > 0 and is_on_floor():
		$PlayerSprite.play("Shoot")
		var bullet_shoot = bullet.instance()
		get_parent().add_child(bullet_shoot)
		
		Global.player_ammo -= 1
		
		if $PlayerSprite.flip_h == true:
			bullet_shoot.position.x = position.x - 35
			bullet_shoot.position.y = position.y - 15
			bullet_shoot.direction = -1
		elif $PlayerSprite.flip_h == false:
			bullet_shoot.position.x = position.x + 35
			bullet_shoot.position.y = position.y - 15
			bullet_shoot.direction = 1
	
	#Gravity and Movement
	velocity.y += GRAVITY
	velocity = move_and_slide(velocity,Vector2.UP)
	
	#Fall Damage
	
	
	
	#Death
	if Global.player_health <= 0:
		get_tree().change_scene("res://Menu.tscn")
	
	#Health Range
	if Global.player_health > 20:
		Global.player_health = 20
	elif Global.player_health < 0:
		Global.player_health = 0
		
	#Ammo Range
	if Global.player_ammo > 6:
		Global.player_ammo = 6
	elif Global.player_ammo < 0:
		Global.player_ammo = 0


#Shooting Animation Stop
func _on_PlayerSprite_animation_finished():
	if $PlayerSprite.animation == "Shoot":
		$PlayerSprite.animation = "Idle"


#Gluton Damage
func _on_Glutton_attack():
	Global.player_health -= randi()%4+3


###PICKUPS###
#Ammo Pickup
func _on_Ammo_collected():
	Global.player_ammo += randi()%2+1


#MRE Pickup
func _on_MRE_collected():
	Global.player_health += randi()%3+2
