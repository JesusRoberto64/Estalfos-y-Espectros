extends CharacterBody2D
# Vamos a agregar la logica de golpe para el player
enum STATE {SUCCES, MOVE, FREEZE}
var cur_state = STATE.MOVE

var speed = 180.0 
var direction = 1.0 
# Jump logica
var gravity_jump = 29.0 
var gravity_fall = 30.0
var jump_force = 525.0
var jump_max_counter = 1
var jump_counter = 0
var jump_air_force = 325.0
var jump_move = 0

var anim_mov : Vector2 = Vector2.LEFT 
@onready var sprite : AnimatedSprite2D = $player_sprite 

signal get_beetle

@onready var hit_boxes = $Hit_Boxes # referencia a las cajas de colision
@onready var punch_hitbox = $Hit_Boxes/punch # a la caja de golpe
@onready var knee_hitbox = $Hit_Boxes/knee
var is_attacking = false # Para saber si el personajes esta atacando.

func _ready():
	add_to_group("Player")
	# se conecta animation_finished para cuando la animación termina
	sprite.connect("animation_finished", on_animation_finished) 
	# Cuando la hit box tiene contacto con un enemigo
	hit_boxes.connect("area_entered", on_hitbox_area_entered)

func _physics_process(_delta):
	var move = Vector2.ZERO
	
	match cur_state:
		STATE.MOVE:
			move.x = Input.get_axis('ui_left', 'ui_right')
			
			anim_mov = move
			direction = direction if move.x == 0.0 else sign(move.x)
			
			hit_boxes.scale.x = -direction
			
			var gravity = gravity_jump if velocity.y < 0.0 else gravity_fall
			velocity.y += gravity
			
			var jumped = Input.is_action_just_pressed('jump')
			if jumped and is_on_floor():
				velocity.y = -jump_force
				jump_move = move.x
			
			if not is_on_floor() and jumped and jump_counter > 0:
				velocity.y = -jump_air_force
				jump_counter -= 1
				jump_move = move.x
			elif is_on_floor() and jump_counter != jump_max_counter:
				jump_counter = jump_max_counter
			
			# Lógica de ataque
			var punch_pressed = Input.is_action_just_pressed("punch")
			
			if is_attacking:
				move = attack_handle(punch_pressed, move)
			
			# Lógica de compuerta para cambiar el esto de golpe
			if punch_pressed and not is_attacking: # si presionamos el botón y no estamos atacando
				set_attack(move)
				#is_attacking = true 
				#if is_on_floor():
					#sprite.play("punch")
					#punch_hitbox.disabled = false
				#else:
					#sprite.play("knee")
					#knee_hitbox.disabled = false
			
			
			if is_on_floor():
				velocity.x = move.x * speed
			else:
				if jump_move == 0.0:
					velocity.x = move.x * speed * 0.25
				else:
					velocity.x = jump_move * speed
			
			move_and_slide()
		STATE.SUCCES:
			velocity.y += gravity_fall
			if is_on_floor():
				sprite.play("succes")
				cur_state = STATE.FREEZE
			move_and_slide()
	
	if position.y >= 500.0:
		get_tree().call_deferred('reload_current_scene')

func _process(_delta):
	if cur_state == STATE.FREEZE or is_attacking: return # Agregamos nueva condicion en el flujo
	
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

func set_attack(_move: Vector2):
	is_attacking = true 
	if is_on_floor():
		sprite.play("punch")
		punch_hitbox.disabled = false
	else:
		sprite.play("knee")
		knee_hitbox.disabled = false
	
	pass

func attack_handle(_punch_pressed : bool, _move: Vector2) -> Vector2:
	if is_on_floor():
		match sprite.animation:
			"punch":
				punch_hitbox.disabled = true 
				if _punch_pressed: 
					sprite.play("punch")
					sprite.frame = 0 
					punch_hitbox.disabled = false 
				_move.x = 0.0
				return _move
			"punch_end":
				return Vector2(0.0, _move.y)
			"knee":
				knee_hitbox.disabled = true
				is_attacking = false
	return _move

func on_animation_finished() -> void: # Cuando la animación termina
	if sprite.animation == "punch": # Si acabón la animación de punch
		sprite.play("punch_end")
	elif sprite.animation == "punch_end":
		punch_hitbox.disabled = true # desactivamos la colisión de golpe
		is_attacking = false # cancelamos el estado de golpe

func succes():
	cur_state = STATE.SUCCES
	velocity = Vector2.ZERO
	anim_mov = Vector2.ZERO

func on_hitbox_area_entered(area: Area2D) -> void: # Funcion conectada cuando entra en contacto la hitbox 
	if area.get_parent().has_method("hurt"):# verifica si al area se le puede dañar
		area.get_parent().hurt() # Respera la estructura de que el padre tiene una area
