extends Area2D

signal reload

#Ammo Pickup
func _on_Ammo_body_entered(_body):
	if Global.player_ammo < 6:
		Global.player_ammo += randi()%2+1
		emit_signal("reload")
		queue_free()


func _on_MRE_body_entered(body):
	body.queue_free()
