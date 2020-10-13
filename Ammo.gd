extends Area2D


#Pickup Signal
signal collected
func _on_Ammo_body_entered(body):
	emit_signal("collected")
	queue_free()
