extends CanvasLayer

onready var player = get_node("/root/City Enviro/Player")

func _process(_delta):
	#Layer
	$Ammo_Bar.set_as_toplevel(true)
	#Frame
	$Ammo_Bar.set_frame(Global.player_ammo)
