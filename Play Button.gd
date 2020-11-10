extends TextureButton


func _on_Play_Button_pressed():
	$SoundPressed.play()
	get_tree().change_scene("res://City Enviro.tscn")
	
