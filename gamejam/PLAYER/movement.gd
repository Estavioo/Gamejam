extends CharacterBody2D

var direction: Vector2 = Vector2()

#@export var speed: int = 250
@export var Bullets = preload("res://projectile/seed_projectile.tscn"	)


var enemy_in_range = false
var enemy_cooldown = true
var HP = 100
var p_alive = true

var atk_ip = false

func _ready():
	$AnimationPlayer.play("walking")

# Animation
func play_animation():
	if direction == Vector2.DOWN:
		$AnimationPlayer.play("walking")
	elif direction == Vector2.RIGHT:
		$Sprite2D.flip_h = false
		$AnimationPlayer.play("walking")
	elif direction == Vector2.UP:
		$AnimationPlayer.play("walking")
	elif direction == Vector2.LEFT:
		$Sprite2D.flip_h = true
		$AnimationPlayer.play("walking")
	else:
		$AnimationPlayer.play("idle")

# Movement
func read_input():
	var new_velocity = Vector2()
	direction = Vector2(0, 0)  # Reset direction to (0, 0)

	if Input.is_action_pressed("ui_up"):
		new_velocity.y -= 1
		direction = Vector2(0, -1)
	elif Input.is_action_pressed("ui_down"):
		new_velocity.y += 1
		direction = Vector2(0, 1)
	elif Input.is_action_pressed("ui_right"):
		new_velocity.x += 1
		direction = Vector2(1, 0)
	elif Input.is_action_pressed("ui_left"):
		new_velocity.x -= 1
		direction = Vector2(-1, 0)

	velocity = new_velocity.normalized() * 200

func _physics_process(delta):
	read_input()
	play_animation()
	move_and_slide()
	enemy_attack()
	update_health()
	atk()
	atk_range()

	if Input.is_action_just_pressed("Seeds"):
		shoot()
	
	$Node2D.look_at(get_global_mouse_position())
	
	if HP <= 0:
		p_alive = false
		HP = 0
		print("Player DEAD")
		self.queue_free()

func player():
	pass


func _on_player_hitbox_body_entered(body):
	if body.has_method("enemy"):
		enemy_in_range = true

func _on_player_hitbox_body_exited(body):
	if body.has_method("enemy"):
		enemy_in_range = false
		
		
	
func enemy_attack():
	if enemy_in_range and enemy_cooldown == true:
		HP = HP - 20
		enemy_cooldown = false
		$atk_cooldown.start()
		print(HP)

func _on_atk_cooldown_timeout():
	enemy_cooldown = true
	
	
func atk():
	if Input.is_action_just_pressed("NormalAtk"):
		GlobalScript.player_current_atk = true
		atk_ip = true
		$player_atk_cooldown.start()
		
func atk_range():
	if Input.is_action_just_pressed("Seeds"):
		GlobalScript.player_current_atk = true
		atk_ip = true
		$range_cooldown.start()		
	
		
func update_health():
	var healthbar = $HP_Bar
	healthbar.value = HP
	

func _on_regen_timeout():
	if enemy_in_range == false:
		if HP < 100:
			HP = HP + 10
			print(HP)
			if HP > 100:
				HP = 100
		if HP <=0:
			HP = 0


func _on_player_atk_cooldown_timeout():
	GlobalScript.player_current_atk = false
	atk_ip = false
	$player_atk_cooldown.stop()
	
func shoot():
	var bul = Bullets.instantiate()
	get_tree().root.add_child(bul)
	bul.transform = $Node2D/Muzzle.global_transform


func _on_range_cooldown_timeout():
	$range_cooldown.stop()
	GlobalScript.player_current_atk = false
	atk_ip = false
