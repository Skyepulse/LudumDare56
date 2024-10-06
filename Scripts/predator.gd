extends CharacterBody2D

class_name Predator

var target_stack: Vivier
@export var speed = 10 

func _ready():
	# Set the predator's position a random position in the world
	position = Vector2(randf_range(0, 1920), randf_range(0, 1080))

func _process(delta):
	# Predator velocity is towards the target
	velocity = (target_stack.position - position).normalized() * speed
	move_and_slide()
