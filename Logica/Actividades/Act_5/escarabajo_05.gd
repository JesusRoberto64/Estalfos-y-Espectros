extends Area2D

func _on_body_entered(body):
	$CollisionShape2D.call_deferred('set_disabled', true)
	$AnimatedSprite2D.play("desapear")
	body.emit_signal("get_beetle")

func _on_animated_finished():
	queue_free()
