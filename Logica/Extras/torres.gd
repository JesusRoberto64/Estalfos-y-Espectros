extends Node2D # Torres

var Towers
var spawn_pos
var speed = 55.0
var last_tower
var dist_between = 125.0

var freeze = false

func _ready():
	var init_pos = 174.0
	Towers = get_children()
	for i in Towers.size(): 
		Towers[i].position.x = init_pos + (dist_between * i)
		Towers[i].position.y = randf_range(-60.0, 30.0)
	spawn_pos = init_pos + (dist_between * Towers.size())
	
	last_tower = Towers[Towers.size() - 1]

func _physics_process(delta):
	if freeze: return
	
	for i in Towers:
		i.position.x -= speed * delta
		if i.position.x < -50.0:
			i.position.x = last_tower.position.x + dist_between
			last_tower = i
			i.position.y = randf_range(-50.0, 24.0)

func set_freeze(state):
	freeze = state
