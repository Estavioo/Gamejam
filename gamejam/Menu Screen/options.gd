extends Control

func _on_video_pressed():
	get_tree().change_scene_to_file("res://Menu Screen/video.tscn")


func _on_audio_pressed():
	get_tree().change_scene_to_file("res://Menu Screen/audio.tscn")


func _on_back_pressed():
	get_tree().change_scene_to_file("res://Menu Screen/menu.tscn")
