extends CharacterBody2D

var speed = 100.0
var gravity = 20.0
var direction = -1.0
var hp : int = 3
var destroyed = false
var hurt_timer = 0.0

@onready var sprite = $AnimatedSprite2D

func _ready():
	sprite.connect("animation_finished", on_animation_finished)

func _physics_process(delta):
	if destroyed: return
	
	velocity.y += gravity
	if is_on_floor():
		velocity.x = direction * speed
	
	if hurt_timer > 0.0:
		hurt_timer -= delta
		velocity.x = 0.0
	
	move_and_slide()
	
	# Para cambiar direction
	if is_on_wall():
		var collision = get_last_slide_collision()
		if collision.get_collider() is TileMapLayer:
			direction = direction * -1.0

func _process(_delta):
	if destroyed : return
	sprite.flip_h = true if direction > 0.0 else false
	
	if hurt_timer > 0.0:
		sprite.play("hurt")
	elif is_on_floor():
		sprite.play("walk")
	

func _on_area_body_entered(body):
	if body.is_in_group("Player"):
		get_tree().call_deferred('reload_current_scene')

func hurt(dammage: int = 1) -> void:
	if destroyed : return
	hp -= dammage
	hurt_timer = 0.15
	if hp <= 0:
		sprite.play("destruction")
		destroyed = true
		$Area2D.set_deferred('monitoring', false)

func on_animation_finished() -> void:
	queue_free()
