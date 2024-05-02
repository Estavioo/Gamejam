extends Control

@onready var transition= $Transition

var nscene = preload("res://test.tscn")

func _on_start_pressed():
	get_tree().change_scene_to_file("res://test.tscn")
	transition.play("fade_out")
	

func _on_options_pressed():
	get_tree().change_scene_to_file("res://Menu Screen/options.tscn")


func _on_exit_pressed():
	get_tree().quit()

func _on_transition_animation_finished(anim_name):
	get_tree().change_scene_to_packed(nscene)
