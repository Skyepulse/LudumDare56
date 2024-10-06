extends Area2D

@onready var animal = $".."

static var picked: bool = false

func _input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		if not picked and event.is_pressed():
			picked = true
			animal.on_press()
		elif event.is_released():
			picked = false
			animal.on_release()
