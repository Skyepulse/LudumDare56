extends Node2D

class_name ThrowArea

@onready var throwArea: Area2D = $Area2D

static var instance: ThrowArea

func _ready():
	throwArea.body_entered.connect(animal_entered_throw_area)
	throwArea.body_exited.connect(animal_left_throw_area)
	
	if instance == null:
		instance = self
	else:
		queue_free()
		return

func animal_entered_throw_area(animal):
	if animal.has_method("add_throw_arrow"):
		animal.is_in_throw_area = true
		animal.add_throw_arrow()

func animal_left_throw_area(animal):
	if animal.has_method("remove_throw_arrow"):
		animal.is_in_throw_area = false
		animal.remove_throw_arrow()

@onready var sprite_2d = $Sprite2D

func highlight():
	sprite_2d.material.set("shader_parameter/on", true);

func un_highlight():
	sprite_2d.material.set("shader_parameter/on", false);
	
