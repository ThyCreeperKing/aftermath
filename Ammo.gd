extends Area2D


#Ammo Pickup
func _on_Ammo_body_entered(_body):
	if Global.player_ammo < 6:
		Global.player_ammo += randi()%2+1
		$SoundReload.play()
		queue_free()
	
#Bounce Animation
func _process(_delta):
	$Sprite.play()
