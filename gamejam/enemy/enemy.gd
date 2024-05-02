extends CharacterBody2D

var enem_spd = 100
var p_chase = false
var player = null
var enem_hp = 100
var player_in_range = false
var can_be_damaged = true

func _physics_process(delta):
	if p_chase:
		position += (player.position - position)/enem_spd
	
	if Input.is_action_just_pressed("Seeds"):
		damage_range()
	else:
		damage_melee()
		
	update_hp()
	


func _on_detection_area_body_entered(body):
	player = body
	p_chase = true
	

func _on_detection_area_body_exited(body):
	player = null
	p_chase = false

func enemy():
	pass


func _on_hitbox_enemy_body_entered(body):
	if body.has_method("player"):
		player_in_range = true


func _on_hitbox_enemy_body_exited(body):
	if body.has_method("player"):
		player_in_range = false

func damage_melee():
	if player_in_range and GlobalScript.player_current_atk == true:
		if can_be_damaged == true:
			enem_hp = enem_hp - 10
			$take_damage.start()
			can_be_damaged = false
			print("Shadow health =", enem_hp)
			if enem_hp <= 0:
				self.queue_free()

func damage_range():
	if Input.is_action_just_pressed("Seeds"):
		if can_be_damaged == true:
			enem_hp = enem_hp - 10
			$take_damage.start()
			can_be_damaged = false
			if enem_hp <=0:
				self.queue_free()

func update_hp():
	var enem_HP = $Enem_HP
	enem_HP.value = enem_hp
	

func _on_take_damage_timeout():
	can_be_damaged = true
