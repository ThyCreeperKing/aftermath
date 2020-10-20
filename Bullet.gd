extends Area2D

###VARIABLE SETUP###
var direction = 1
const BULLET_SPEED = 35

###BULLET LOOP###
func _physics_process(_delta):
	position.x += BULLET_SPEED * direction
