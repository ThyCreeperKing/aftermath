extends Area2D


#Pickup Signal
signal collected
func _on_Ammo_body_entered(_body):
	Global.player_ammo += randi()%2+1
	queue_free()
	
#Animation
func _process(_delta):
	$Sprite.play()
