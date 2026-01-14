extends Node2D

@onready var Player = $Player

var beetles : int = 0
@onready var beetle_lab = $CanvasLayer/Beetle

func _ready() -> void:
	# Conectar señales 
	Player.connect("get_beetle", get_beetle)

func get_beetle() -> void:
	beetles = beetles + 1
	beetle_lab.text = "x " + str(beetles)
