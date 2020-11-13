extends CanvasLayer


onready var player = get_node("/root/City Enviro/Player")


func _process(_delta):
	#Layer
	$Ammo_Bar.set_as_toplevel(true)
	#Frame
	$Ammo_Bar.set_frame(Global.player_ammo)


func _on_Player_ammogain():
	$Ammo_Bar.modulate = Color(10,10,10,10)
	yield(get_tree().create_timer(0.15), "timeout")
	$Ammo_Bar.modulate = Color(1,1,1,1)
