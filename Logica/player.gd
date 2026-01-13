extends CharacterBody2D

var speed = 250.0
var direction = 1.0
var gravity = 30.0
var jump_force = 500.0


var anim_mov : Vector2 = Vector2.LEFT
@onready var sprite = $player_sprite 

func _physics_process(_delta):
	var dir = Input.get_vector('ui_left', 'ui_right', 'ui_up', 'ui_down')
	anim_mov = dir
	direction = direction if dir.x == 0.0 else dir.x
	
	velocity.y += gravity
	if Input.is_action_just_pressed('ui_accept') and (is_on_floor() or position.y == 135.0):
		velocity.y = -jump_force
	
	
	velocity.x = dir.x * speed
	move_and_slide()
	
	# Limite de suelo
	position.y = min(135.0, position.y)
	

func _process(_delta):
	sprite.flip_h = true if direction > 0.0 else false
	
	if position.y >= 135.0 or is_on_floor():
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
