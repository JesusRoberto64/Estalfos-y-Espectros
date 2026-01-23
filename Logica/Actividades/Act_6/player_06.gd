extends CharacterBody2D
# Ponemos en grupo al player para que el Hazard lo reconozca.
var speed = 180.0 
var direction = 1.0 
var gravity = 30.0 
var jump_force = 550.0

var anim_mov : Vector2 = Vector2.LEFT 
@onready var sprite = $player_sprite 

signal get_beetle

func _ready() -> void: # Añadir a grupo de jugador para ser reconocido por los Hazards
	add_to_group("Player") # Añadimos al grupo Player

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
	
	if position.y >= 500.0:
		get_tree().reload_current_scene()

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
