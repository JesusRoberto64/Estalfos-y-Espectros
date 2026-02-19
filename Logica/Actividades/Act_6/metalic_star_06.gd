extends Area2D

@export var direction = Vector2.DOWN
@export var speed = 100.0
@export var can_move = false

@export var respaw_dist = 150.0
var up_dist = Vector2.ZERO
var down_dist = Vector2.ZERO

func _ready() -> void:
	if can_move:
		up_dist = position - direction * respaw_dist
		down_dist = position + direction * respaw_dist

func _physics_process(delta) -> void:
	if can_move:
		position += direction * speed * delta
		position.y = wrapf(position.y, up_dist.y, down_dist.y)
		
		

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		set_deferred('monitoring', false)
		get_tree().call_deferred('reload_current_scene')
