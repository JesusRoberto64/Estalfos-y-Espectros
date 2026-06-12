extends CharacterBody2D

@export var hp : float = 3
@export var speed = 85.0
var gravity = 20.0
var direction = -1.0
var destroyed = false
var hurt_timer = 0.0
var hurt_timer_max = 0.4
var is_hurt = false
var is_rising = true

@onready var sprite = $AnimatedSprite2D
@onready var col_shape = $CollisionShape2D
@onready var hazard_area : Area2D = $Area2D
@onready var harzard_shape : CollisionShape2D = $Area2D/CollisionShape2D

func _ready():
	sprite.connect("animation_finished", on_animation_finished)
	col_shape.disabled = true
	harzard_shape.disabled = true
	
	sprite.play("rise")
	sprite.flip_h = true if direction > 0.0 else false
	sprite.modulate.a = 0.6

func _physics_process(delta):
	if destroyed or is_rising: return
	
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
	if destroyed or is_rising: return
	sprite.flip_h = true if direction > 0.0 else false
	
	if hurt_timer > 0.0:
		sprite.play("hurt")
	elif is_on_floor():
		sprite.play("walk")
		harzard_shape.disabled = false

func _on_area_body_entered(body):
	if body.is_in_group("Player"):
		body.hurt()
		#get_tree().call_deferred('reload_current_scene')

func hurt(dammage: float = 1.0) -> void:
	if destroyed or is_rising: return
	hp -= dammage
	hurt_timer = hurt_timer_max
	harzard_shape.set_deferred("disabled", true)
	if hp <= 0:
		sprite.play("destruction")
		destroyed = true
		col_shape.call_deferred("set_disabled", true)

func on_animation_finished() -> void:
	if sprite.animation == "rise":
		is_rising = false
		col_shape.disabled = false
		harzard_shape.disabled = false
		sprite.modulate.a = 1.0
		return
	queue_free()
