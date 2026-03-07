extends Area2D

@export var name_str  : String = ""
@export_multiline var text : String = ""

var Player = null
var Dialog = null

var can_read = false
var reading = false

func _ready():
	for i in get_tree().get_nodes_in_group("DiPanel"):
		Dialog = i
		Dialog.on_dialog_ended.connect(end_reading)
		
	print(Dialog)

func _process(_delta):
	if can_read and not reading and Input.is_action_just_pressed("ui_accept"):
		Player.is_freeze = true
		Dialog.show_dialog(text, name_str)
		reading = true

func _on_body_entered(body):
	can_read = true
	Player = body

func _on_body_exited(_body):
	can_read = false

func end_reading() -> void:
	Player.is_freeze = false
	reading = false
	Dialog.hide_dialog()
