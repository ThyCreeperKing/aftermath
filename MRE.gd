extends Area2D


#Pickup Signal
signal collected
func _on_MRE_body_entered(_body):
	emit_signal("collected")
	queue_free()

#Animation
func _process(delta):
	$Sprite.play()
