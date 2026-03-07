extends CanvasLayer

@export var name_str = ""
@export_multiline var text: String = ""

@onready var text_label = $Panel/RichTextLabel
@onready var name_label = $Panel/name/Label
@onready var panel = $Panel

var is_typing = false
signal on_dialog_ended

func _ready():
	panel.hide()
	add_to_group("DiPanel")

func _process(delta):
	if is_typing:
		text_label.visible_ratio += delta
		if text_label.visible_ratio == 1.0:
			is_typing = false
	elif panel.visible == true:
		if Input.is_action_just_released("ui_accept"):
			hide_dialog()
			on_dialog_ended.emit()

func show_dialog(_text, _name : String = "") -> void:
	text_label.text = _text
	name_label.text = _name
	panel.show()
	text_label.visible_ratio = 0.0
	is_typing = true

func hide_dialog() -> void:
	panel.hide()
	text_label.text = ""
	name_label.text = ""
	is_typing = false

func end_dialog() -> void:
	is_typing = 1.0
	on_dialog_ended.emit()
