extends Area2D

func _on_body_entered(_body: Node2D) -> void:
	set_deferred('monitoring', false)
	get_tree().call_deferred('reload_current_scene')
