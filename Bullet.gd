extends Area2D

###VARIABLE SETUP###
var direction = 1
const BULLET_SPEED = 20

signal gluttonshot

###BULLET LOOP###
func _physics_process(_delta):
	position.x += BULLET_SPEED * direction
	
	if direction == -1:
		$Bullet_Sprite.flip_h = true


func _on_Bullet_body_entered():
	emit_signal("gluttonshot")
	queue_free()
