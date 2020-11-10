extends Area2D

signal healed

#MRE Pickup
func _on_MRE_body_entered(_body):
	if Global.player_health < 20:
		Global.player_health += randi()%5+3
		emit_signal("healed")
		queue_free()

