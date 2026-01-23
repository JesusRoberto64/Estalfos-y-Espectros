extends CharacterBody2D

var speed = 180.0 
var direction = 1.0 
var gravity = 30.0 
var jump_force = 550.0

var anim_mov : Vector2 = Vector2.LEFT 
@onready var sprite = $player_sprite 

signal get_beetle # Agregamos esta señal que va emitirse cuando toque el coleccionable

func _physics_process(_delta):
	var move = Vector2.ZERO
	
	if Input.is_action_pressed('ui_right'):
		move.x = 1.0
	elif Input.is_action_pressed('ui_left'):
		move.x = -1.0
	
	anim_mov = move
	direction = direction if move.x == 0.0 else move.x
	
	velocity.y += gravity
	if Input.is_action_just_pressed('ui_accept') and is_on_floor():
		velocity.y = -jump_force
	
	velocity.x = move.x * speed
	move_and_slide()

func _process(_delta):
	sprite.flip_h = true if direction > 0.0 else false
	
	if is_on_floor():
		if anim_mov == Vector2.ZERO:
			sprite.play("idle")
		else:
			sprite.play("walk")
	else:
		if velocity.y != 0.0:
			if velocity.y > 0.0:
				sprite.play("fall")
			else:
				sprite.play("jump")
