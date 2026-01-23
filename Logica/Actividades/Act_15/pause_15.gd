extends CanvasLayer

@export var main_menu : String = "" 

func _ready():
	hide()

func _process(_delta):
	if Input.is_action_just_pressed("pause") and get_tree().paused == false:
		get_tree().paused = true
		show()
		$continue.grab_focus()

func _on_continue_pressed():
	hide()
	get_tree().paused = false

func _on_restart_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()

func _on_main_menu_pressed():
	get_tree().paused = false
	if main_menu != "":
		get_tree().change_scene_to_file(main_menu)
