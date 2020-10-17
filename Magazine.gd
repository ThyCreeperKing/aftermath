extends AnimatedSprite

onready var player = get_node("/root/City Enviro/Player")

func _ready():
	set_frame(0)

func _process(delta):
	set_as_toplevel(true)
	position.x = player.position.x + 400
	position.y = player.position.y + 215
	
