extends CanvasLayer

onready var player = get_node("/root/City Enviro/Player")

func _process(_delta):
	#Layer
	$Health_Bar.set_as_toplevel(true)
	#Frame
	$Health_Bar.set_frame(Global.player_health)


func _on_Player_healthgain():
	$Health_Bar.modulate = Color(0,1,0,1)
	yield(get_tree().create_timer(0.15), "timeout")
	$Health_Bar.modulate = Color(1,1,1,1)


func _on_Player_healthloss():
	$Health_Bar.modulate = Color(1,0,0,1)
	yield(get_tree().create_timer(0.15), "timeout")
	$Health_Bar.modulate = Color(1,1,1,1)
