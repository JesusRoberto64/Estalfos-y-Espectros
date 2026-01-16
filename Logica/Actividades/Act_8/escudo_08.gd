extends Area2D

@export var to_level : String = "" 
@onready var anim = $AnimatedSprite2D

func _ready():
	anim.animation_finished.connect(on_animation_finished)

func succes() -> void:
	set_deferred('monitoring', false)
	anim.play("succes")

func on_animation_finished() -> void:
	Globals.next_level(to_level)
