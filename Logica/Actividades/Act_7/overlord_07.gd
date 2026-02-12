extends Node2D

@onready var Player = $Player
@onready var Meta = $Escudo # $Nombre_de_Nodo

@onready var succes_lab = $CanvasLayer/Succes

var beetles : int = 0
@onready var beetle_lab = $CanvasLayer/Beetle

func _ready() -> void:
	# Conectar señales 
	Player.connect("get_beetle", get_beetle)
	Meta.connect("body_entered", succes)

func get_beetle() -> void:
	beetles = beetles + 1
	beetle_lab.text = "x " + str(beetles)

func succes(_body):
	succes_lab.show()
	Player.succes()
	Meta.get_child(0).play("succes")
	Meta.set_deferred('monitoring', false)
