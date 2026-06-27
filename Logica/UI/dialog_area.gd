extends Area2D

@export var name_str : String = ""
@export_multiline var text : String = ""

var Player = null
var Dialog = null

var can_read = false
var reading = false

func _ready() -> void:
	Dialog = $CanvasLayer

func _process(_delta) -> void:
	if can_read and not reading and Input.is_action_just_pressed("ui_accept"):
		Player.toggle_freeze()
		Dialog.show_dialog(text, name_str)
		reading = true

func _on_body_entered(body) -> void:
	can_read = true
	Player = body

func _on_body_exited(_body) -> void:
	can_read = false

func _on_canvas_layer_dialog_ended() -> void:
	Player.toggle_freeze()
	reading = false
	Dialog.hide_dialog()
