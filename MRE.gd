extends Area2D


#Pickup Signal
signal collected
func _on_MRE_body_entered(_body):
	Global.player_health += randi()%3+2
	queue_free()

#Animation
func _process(_delta):
	$Sprite.play()
