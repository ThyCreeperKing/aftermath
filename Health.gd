extends AnimatedSprite

onready var player = get_node("/root/City Enviro/Player")

func _ready():
	set_frame(20)

func _process(delta):
	set_as_toplevel(true)
	position.x = player.position.x - 415
	position.y = player.position.y + 215
	set_frame(player.health)
