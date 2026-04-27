extends AnimatedSprite2D # Personaje tipo Flappy

var gravity = 7.0
var jump_force = 2.5
var velocity = 0.0

var frezze = false

func _physics_process(delta):
	if frezze: return
	
	if Input.is_action_just_pressed("ui_accept"):
		velocity = -jump_force
	
	velocity += gravity * delta
	position.y += velocity
	
	velocity = clamp(velocity, -3.0, 5.0)
	position.y = clamp(position.y, -20.0 ,195.0)

func _on_area_2d_area_entered(area):
	get_tree().call_deferred("reload_current_scene")

func set_freeze(state):
	frezze = state
