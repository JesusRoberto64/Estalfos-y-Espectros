extends Label

signal set_freeze(state: bool)

func _ready():
	set_freeze.emit(true)

func _process(delta):
	if Input.is_action_just_released("pause"):
		set_freeze.emit(false)
		hide()
