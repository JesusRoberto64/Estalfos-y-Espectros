extends CharacterBody2D

enum STATE {SUCCES, MOVE, FREEZE}
var cur_state = STATE.MOVE

var speed = 180.0 # velocidad de izquierda derecha
var direction = 1.0 # la direccion que mira nuestro personaje
var gravity = 30.0 
var jump_force = 550.0

var anim_mov : Vector2 = Vector2.LEFT # variable para pasar a process
@onready var sprite : AnimatedSprite2D = $player_sprite # referecnia a animatedsprite2D

signal get_beetle

@onready var hit_boxes = $Hit_Boxes
@onready var punch_hitbox = $Hit_Boxes/punch
var is_attacking = false 

func _ready():
	add_to_group("Player")
	sprite.connect("animation_finished", on_animation_finished)
	hit_boxes.connect("area_entered", on_hitbox_area_entered)

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
			hit_boxes.scale.x = -direction
			
			velocity.y += gravity
			if Input.is_action_just_pressed('jump') and is_on_floor():
				velocity.y = -jump_force
			
			# Lógica de ataque
			var punch_pressed = Input.is_action_just_pressed("punch")
			
			if is_attacking:
				if is_on_floor():
					punch_hitbox.disabled = true
					if punch_pressed:
						sprite.play("punch")
						sprite.frame = 2
						punch_hitbox.disabled = false
					move.x = 0.0
			
			if punch_pressed and not is_attacking:
				is_attacking = true
				sprite.play("punch")
				punch_hitbox.disabled = false
			
			velocity.x = move.x * speed
			move_and_slide()
		STATE.SUCCES:
			velocity.y += gravity
			if is_on_floor():
				# Celebration
				sprite.play("succes")
				cur_state = STATE.FREEZE
			move_and_slide()
	
	if position.y >= 500.0:
		get_tree().reload_current_scene()

func _process(_delta):
	if cur_state == STATE.FREEZE or is_attacking: return
	
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

func on_animation_finished() -> void:
	if sprite.animation == "punch":
		punch_hitbox.disabled = true
		is_attacking = false

func succes():
	cur_state = STATE.SUCCES
	velocity = Vector2.ZERO
	anim_mov = Vector2.ZERO

func on_hitbox_area_entered(area: Area2D) -> void:
	if area.get_parent().has_method("hurt"):
		area.get_parent().hurt()
