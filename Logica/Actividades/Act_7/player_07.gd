extends CharacterBody2D
# Creamos una logica de estados para tenener modos de en nuestro jugador.
enum STATE {SUCCES, MOVE, FREEZE} # Declaramos este enum con la lista de estados
var cur_state = STATE.MOVE # Declaramos variable para alojar ese estado

var speed = 180.0 
var direction = 1.0 
var gravity = 30.0 
var jump_force = 550.0

var anim_mov : Vector2 = Vector2.LEFT 
@onready var sprite = $player_sprite 

signal get_beetle # Nombre del coleccionable

func _ready() -> void:
	add_to_group("Player")

func _physics_process(_delta):
	var move = Vector2.ZERO
	# Usamos la estructura con un match para procesar bloques de logica separados.
	match cur_state: # ponemos un match que revise el valor de cur_state(estado actual)
		STATE.MOVE: # mientras estemos en el STATE.MOVE(estado de movimiento)
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
		STATE.SUCCES:# mientras estamos en el estado al tocar la meta.
			velocity.y += gravity
			if is_on_floor(): # cuando toque el suelo celebrara el personaje
				# Celebration
				sprite.play("succes")
				cur_state = STATE.FREEZE # cambiamos de estado para no viciar el ciclo
			move_and_slide()
	
	if position.y >= 500.0:
		get_tree().reload_current_scene()

func _process(_delta):
	# return termina el proceso que no ocurra ninguan otra animación
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

func succes(): # Esta funcion se llamara cuando se toque la meta
	cur_state = STATE.SUCCES # Cambiamos de estado
	velocity = Vector2.ZERO # Reseteamos velocidad
	anim_mov = Vector2.ZERO # Receteamos animación
