extends Area2D


#MRE Pickup
func _on_MRE_body_entered(body):
	if Global.player_health < 20:
		Global.player_health += randi()%5+3
		$SoundPickup.play()
		queue_free()

#Bounce Animation
func _process(_delta):
	$Sprite.play()
