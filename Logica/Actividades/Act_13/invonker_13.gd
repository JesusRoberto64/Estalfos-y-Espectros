extends Node2D

enum MODE { INFINITE, LIMITED }
@export var cur_mode = MODE.INFINITE

var max_enemy : int = 3
var enemy = preload("res://Escenas/Actividades/Actividad_13/estalfo_13.tscn")
@onready var pool = $Pool

var invoker_timer_limit = 2.0
var invoke_timer = 0.0

func _ready():
	$AnimatedSprite2D.hide()

func _process(delta):
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
	pool.add_child(inst)
	invoke_timer = 0.0
