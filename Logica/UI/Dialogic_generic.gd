extends Area2D

@export_multiline var text : String = ""

var is_typing = false

@onready var Dialog = $CanvasLayer
@onready var Text_lab = $CanvasLayer/Panel/RichTextLabel

var Player = null

func _ready():
	show()
	Dialog.hide()
	Text_lab.visible_ratio = 0.0
	Text_lab.text = text

func _process(delta):
	if is_typing:
		Text_lab.visible_ratio += delta 
		if Text_lab.visible_ratio >= 1.0:
			is_typing = false
	elif Dialog.visible == true:
		if Input.is_action_just_released("ui_accept"):
			Player.toggle_freeze()
			queue_free()

func _on_body_entered(body):
	Dialog.show()
	is_typing = true
	Player = body
	body.toggle_freeze()
