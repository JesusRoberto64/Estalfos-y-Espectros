extends Area2D

var direction = 1.0
var speed = 480.0

func _physics_process(delta):
	position.x += speed * direction * delta

func _on_body_entered(body):
	if body.has_method("hurt"):
		body.hurt(1.0)
	queue_free()
