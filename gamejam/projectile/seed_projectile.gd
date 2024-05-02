extends Area2D


@export var spd= 300



func _physics_process(delta):
		position += transform.x * delta * spd 
	


func _on_visible_on_screen_enabler_2d_screen_exited():
	queue_free()
	


func _on_body_entered(body):
	if body.has_method("enemy"):
		GlobalScript.player_current_atk = true
		body.take_damage()
	else:
		body.take_damage()
	queue_free()	
