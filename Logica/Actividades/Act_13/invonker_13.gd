extends Node2D

enum MODE { INFINITE, LIMITED }
@export var cur_mode = MODE.INFINITE

var max_enemy : int = 3
var enemy = preload("res://Escenas/Actividades/Actividad_13/estalfo_13.tscn")
@onready var pool = $Pool

var invoke_timer = 0.0
@export var invoker_timer_limit = 2.0

var can_invoke = false
var player = null

func _ready():
	invoke_timer = invoker_timer_limit
	$AnimatedSprite2D.hide()
	if get_tree().get_nodes_in_group("Player").size() > 0:
		player = get_tree().get_nodes_in_group("Player")[0]

func _process(delta):
	if not can_invoke : return
	match cur_mode:
		MODE.INFINITE:
			if pool.get_child_count() < max_enemy:
				invoke_timer += delta
				if invoke_timer >= invoker_timer_limit:
					invoke()
		MODE.LIMITED:
			if max_enemy > 0:
				invoke_timer += delta
				if invoke_timer >= invoker_timer_limit:
					invoke()
					max_enemy -= 1

func invoke() -> void:
	var inst = enemy.instantiate()
	if player != null:
		inst.direction = sign(player.global_position.x - global_position.x)
	pool.add_child(inst)
	invoke_timer = 0.0

func _on_screen_entered() -> void:
	can_invoke = true

func _on_screen_exited() -> void:
	can_invoke = false
	invoke_timer = 0.0
