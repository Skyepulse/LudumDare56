extends Node2D

@onready var throwArea: Area2D = $Area2D

func _ready():
	throwArea.body_entered.connect(animal_entered_throw_area)
	throwArea.body_exited.connect(animal_left_throw_area)


func _process(_delta):
	pass

func animal_entered_throw_area(animal: Animal):
	animal.is_in_throw_area = true
	animal.add_throw_arrow()

func animal_left_throw_area(animal: Animal):
	animal.is_in_throw_area = false
	animal.remove_throw_arrow()