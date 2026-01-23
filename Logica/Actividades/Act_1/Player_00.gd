extends CharacterBody2D

var speed = 3.0 # La velocidad en la que se mueve el personaje
@onready var sprite = $player_sprite # La referencia a nuestro AnimatedSprite2D

func _process(_delta): # Funcion del ciclo que se corre cada frame
	var move = false # El movimiento se resetea como si fuera cero
	
	if Input.is_action_pressed('ui_right'): # Llamndo el boton fecha derecha
		position.x = position.x + speed # Sumamos la posición de x para derecha
		move = true # Afirmamos que el personaje se está moviendo
		sprite.flip_h = true # Espejamos el sprite para que se gire
	if Input.is_action_pressed('ui_left'): # Presionamos boton flecha izquierda
		position.x = position.x - speed # Restamos para la izquierda
		move = true # Afirmamos que el personaje se está moviendo
		sprite.flip_h = false # Espejamos el sprite para que se gire
	
	# Animación 
	if move == true: # Si se está moviendo 
		sprite.play("walk") # Reproducimos la animación de caminar 
	else: # Por otro lado
		sprite.play("idle") # Reproducimos la animción de estar quieto
	
