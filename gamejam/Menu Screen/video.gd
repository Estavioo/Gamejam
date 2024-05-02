extends Control

func _on_fullscreen_toggled(button_pressed):
	if button_pressed == true: 
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)


func _on_borderless_toggled(button_pressed):
	if button_pressed == true:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)


func _on_backto_options_pressed():
	get_tree().change_scene_to_file("res://Menu Screen/options.tscn")
