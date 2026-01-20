extends CharacterBody2D

var speed = 100.0
var gravity = 20.0
var direction = -1.0

@onready var anim = $AnimatedSprite2D

func _physics_process(_delta):
	velocity.y += gravity
	if is_on_floor():
		velocity.x = direction * speed
	
	move_and_slide()
	
	# Para cambiar direction
	if is_on_wall():
		var collision = get_last_slide_collision()
		if collision.get_collider() is TileMapLayer:
			direction = direction * -1.0

func _process(_delta):
	anim.flip_h = true if direction > 0.0 else false
	if is_on_floor():
		anim.play("walk")

func _on_area_body_entered(body):
	if body.is_in_group("Player"):
		set_deferred('monitoring', false)
		get_tree().call_deferred('reload_current_scene')
