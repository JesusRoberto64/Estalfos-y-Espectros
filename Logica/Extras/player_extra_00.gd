extends CharacterBody2D # Simple movimineto TOP-VIEW

var speed = 80.0
var direction = -1.0

@onready var anim = $AnimatedSprite2D
var move_anim = Vector2.ZERO

func _physics_process(_delta):
	var move = Input.get_vector('ui_left', 'ui_right', 'ui_up', 'ui_down')
	move_anim = move
	direction = move.x if move.x != 0.0 else direction
	velocity = move * speed
	move_and_slide()

func _process(_delta):
	anim.flip_h = false if direction < 0.0 else true
	if move_anim != Vector2.ZERO:
		anim.play("walk")
	else:
		anim.play("idle")
	
