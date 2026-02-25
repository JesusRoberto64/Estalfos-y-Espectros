extends AnimatedSprite2D

var blink_timer = 0.35
var blink_timer_max = 0.05

func blinking(delta):
	blink_timer -= delta
	if blink_timer <= 0.0:
		modulate.a *= -1.0 
		blink_timer = blink_timer_max
