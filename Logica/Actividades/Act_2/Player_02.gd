extends CharacterBody2D
# A este sprite le ponemos la lógica de salto con un suelo falso
var speed = 250.0 
var direction = 1.0 # la direccion que mira nuestro personaje
var gravity = 30.0 # Nuestra gravedad
var jump_force = 500.0 # La fuerza del salto

var anim_mov : Vector2 = Vector2.LEFT # variable para pasar a process
@onready var sprite = $player_sprite # referecnia a animatedsprite2D

func _physics_process(_delta): # Llamando la función desde el procesamiento de las físicas
	var move = Vector2.ZERO # Resetamos simepre al principio el movimiento
	
	if Input.is_action_pressed('ui_right'): 
		move.x = 1.0 # en eje x positivo para ir a la derecha
	elif Input.is_action_pressed('ui_left'):
		move.x = -1.0 # en eje x negativo para ir a la izquierda
	
	anim_mov = move # Igualamos el movimento para pasarlo a la animación
	direction = direction if move.x == 0.0 else move.x # si se mueve el personajes
	# la direccion se iguala con el eje x, si no vuelve a ser la misma, esto para que 
	# NO direction = 0.0; SI direction = -1.0 o 1.0 
	
	velocity.y += gravity #  sumamos la gravedad a nuestro eje Y, RECURDA: Y positivo = ABAJO
	# La condición del boton de salto, y estar en la posición de nuesto suelo falso
	if Input.is_action_just_pressed('ui_accept') and position.y == 135.0: 
		velocity.y = -jump_force # se iguala a la velocidad de salto.
	
	velocity.x = move.x * speed # la velocidad de eje x se multiplica por su velocidad
	move_and_slide() # Se llama esta función para calcular las físicas.
	
	# Limite de suelo TEMPORAL
	position.y = min(135.0, position.y)

func _process(_delta):
	# Pasamos la el valor de la direcion si es mayor a cero, osea valor postivo
	# falso si la direccion es negativa
	sprite.flip_h = true if direction > 0.0 else false
	
	if position.y >= 135.0: # Condición de nuestro suelo falso
		# Bloque de logica anterior solo que en su luagar tomamos el vector cuando esta en cero (0.0,0.0)
		if anim_mov == Vector2.ZERO:
			sprite.play("idle")
		else:
			sprite.play("walk")
	else: # De lo contrario
		if velocity.y != 0.0: # Si no esta cayendo o saltando, osea el movimieto vertical no es 0.0
			if velocity.y > 0.0: # Si bjamos en eje Y el valor es positivo 
				sprite.play("fall")
			else:# Si subimos en eje Y el valor es negativo
				sprite.play("jump") 
