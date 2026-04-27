extends Parallax2D

func set_freeze(state):
	if state:
		autoscroll.x = 0.0
	else:
		autoscroll.x = -50.0
