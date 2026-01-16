extends Node2D

@onready var Player = $Player
@onready var Escudo = $Escudo

@onready var succes_lab = $CanvasLayer/Succes

var beetles : int = 0
@onready var beetle_lab = $CanvasLayer/Beetle

func _ready() -> void:
	# Conectar señales 
	Player.connect("get_beetle", get_beetle)
	Escudo.connect("body_entered", succes)

func get_beetle() -> void:
	beetles = beetles + 1
	beetle_lab.text = "x " + str(beetles)

func succes(_body):
	succes_lab.show()
	Player.succes()
	#Escudo.get_child(0).play("succes")
	#Escudo.set_deferred('monitoring', false)
	Escudo.succes()
	
