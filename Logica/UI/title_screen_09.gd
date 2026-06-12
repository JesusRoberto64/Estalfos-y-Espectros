extends Node2D

@onready var start_btn = $CanvasLayer/Comenzar
@onready var exit_btn = $CanvasLayer/Salir

@export var level : PackedScene = null

func _ready() -> void:
	start_btn.grab_focus()
	start_btn.pressed.connect(start)
	exit_btn.pressed.connect(exit)

func start() -> void:
	get_tree().change_scene_to_packed(level)

func exit() -> void:
	get_tree().quit()
