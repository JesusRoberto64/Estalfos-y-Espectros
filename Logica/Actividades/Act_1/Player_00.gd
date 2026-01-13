extends CharacterBody2D

var speed = 3.0
@onready var sprite = $player_sprite

func _process(_delta):
	var move = false
	
	if Input.is_action_pressed('ui_right'):
		position.x = position.x + speed
		move = true
		sprite.flip_h = true
	if Input.is_action_pressed('ui_left'):
		position.x = position.x - speed
		move = true
		sprite.flip_h = false
	
	# Animación 
	if move == true:
		sprite.play("walk")
	else:
		sprite.play("idle")
	
