extends CanvasLayer

onready var player = get_node("/root/City Enviro/Player")

func _process(_delta):
	#Layer
	$Health_Bar.set_as_toplevel(true)
	#Frame
	$Health_Bar.set_frame(Global.global_health)
