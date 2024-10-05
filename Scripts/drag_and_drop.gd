extends Area2D

@onready var animal = $".."

func _input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		if event.is_pressed():
			animal.on_press()
		elif event.is_released():
			animal.on_release()
