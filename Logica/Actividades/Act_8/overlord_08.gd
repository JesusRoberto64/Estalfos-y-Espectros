extends Node2D

@onready var Player = $Player
@onready var Escudo = $Escudo

@onready var succes_lab = $UI/Succes

var beetles : int = 0
@onready var beetle_lab = $UI/Beetle

@onready var hp_bar = $UI/HpBar 

func _ready() -> void:
	# Conectar señales 
	Player.connect("get_beetle", get_beetle)
	Escudo.connect("body_entered", succes)
	Player.connect("set_hp", set_hp)

func get_beetle() -> void:
	beetles = beetles + 1
	beetle_lab.text = "x " + str(beetles)

func succes(_body):
	succes_lab.show()
	Player.succes()
	Escudo.succes()

func set_hp(hp) -> void:
	hp_bar.value = hp
