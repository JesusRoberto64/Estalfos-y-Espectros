extends CharacterBody2D

enum STATE {SUCCES, MOVE, FREEZE}
var cur_state = STATE.MOVE

var speed = 180.0 
var direction = 1.0 
var gravity = 30.0 
var jump_force = 550.0

var anim_mov : Vector2 = Vector2.LEFT 
@onready var sprite = $player_sprite 

signal get_beetle

func _ready():
	add_to_group("Player")

func _physics_process(_delta):
	var move = Vector2.ZERO
	
	match cur_state:
		STATE.MOVE:
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
		STATE.SUCCES:
			velocity.y += gravity
			if is_on_floor():
				sprite.play("succes")
				cur_state = STATE.FREEZE
			move_and_slide()
	
	if position.y >= 500.0:
		get_tree().reload_current_scene()

func _process(_delta):
	if cur_state == STATE.FREEZE: return
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

func succes():
	cur_state = STATE.SUCCES
	velocity = Vector2.ZERO
	anim_mov = Vector2.ZERO
