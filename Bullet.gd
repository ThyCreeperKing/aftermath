extends Area2D

###VARIABLE SETUP###
var direction = 1
const BULLET_SPEED = 20


###BULLET LOOP###
func _physics_process(_delta):
	position.x += BULLET_SPEED * direction
	
	if direction == -1:
		$Bullet_Sprite.flip_h = true
