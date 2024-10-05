class_name Voiture

extends CharacterBody2D

@export var speed : int


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	velocity = speed*Vector2(1,0)
	move_and_slide()
	
