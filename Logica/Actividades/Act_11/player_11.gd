extends CharacterBody2D
# Vamos a agregar la logica de golpe para el player
enum STATE {SUCCES, MOVE, FREEZE}
var cur_state = STATE.MOVE

var speed = 180.0 
var direction = 1.0 
var gravity = 30.0 
var jump_force = 550.0

var anim_mov : Vector2 = Vector2.LEFT 
@onready var sprite : AnimatedSprite2D = $player_sprite 

signal get_beetle

@onready var hit_boxes = $Hit_Boxes # referencia a las cajas de colision
@onready var punch_hitbox = $Hit_Boxes/punch # a la caja de golpe
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
			# Si acabamos de presionar el botón de ataque.
			var punch_pressed = Input.is_action_just_pressed("punch")
			
			if is_attacking: # Bloque de lógica cuando está atacando.
				if is_on_floor(): # Si estamos el suelo
					punch_hitbox.disabled = true # Desactivamos la caja de colisión
					if punch_pressed: # Si acabamos de presionar el botón de ataque
						sprite.play("punch") # Reproducimos la animación de golpe
						sprite.frame = 2 # para adelantar la animación y ser mas rapido
						punch_hitbox.disabled = false # Activamos la colisión
					move.x = 0.0 # Paramos el movimiento
			
			# Lógica de compuerta para cambiar el esto de golpe
			if punch_pressed and not is_attacking: # si presionamos el botón y no estamos atacando
				is_attacking = true # cerramos la compuerta
				sprite.play("punch")# reproducimos animación
				punch_hitbox.disabled = false # activamos la colisión
			
			velocity.x = move.x * speed
			move_and_slide()
		STATE.SUCCES:
			velocity.y += gravity
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

func on_animation_finished() -> void: # Cuando la animación termina
	if sprite.animation == "punch": # Si acabón la animación de punch
		punch_hitbox.disabled = true # desactivamos la colisión de golpe
		is_attacking = false # cancelamos el estado de golpe

func succes():
	cur_state = STATE.SUCCES
	velocity = Vector2.ZERO
	anim_mov = Vector2.ZERO

func on_hitbox_area_entered(area: Area2D) -> void: # Funcion conectada cuando entra en contacto la hitbox 
	if area.get_parent().has_method("hurt"):# verifica si al area se le puede dañar
		area.get_parent().hurt() # Respera la estructura de que el padre tiene una area
