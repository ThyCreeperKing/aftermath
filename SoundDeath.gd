extends AudioStreamPlayer


func _on_Glutton_dead():
	play()
	yield(self, "finished")
