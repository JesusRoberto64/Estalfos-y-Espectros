extends Node

var current_level = ""

func next_level(_leve: String) -> void:
	if _leve == "" or _leve == null: return
	
	current_level = _leve
	get_tree().change_scene_to_file(_leve)
