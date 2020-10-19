extends AnimatedSprite

onready var player = get_node("/root/City Enviro/Player")

func _process(delta):
	#Position
	set_as_toplevel(true)
	position.x = player.position.x + 400
	position.y = player.position.y + 215

