extends CharacterBody2D

class_name Predator

enum PredatorState {
	ATTACKING = 0,
	EATING = 1,
	FLEEING = 2,
	HELD = 3
}

var state: PredatorState = PredatorState.ATTACKING
var is_in_stack: bool = false

var target_stack: Vivier
@export var speed = 50 
@export var kind: Animal.AnimalType

@onready var timer = $Timer


func _ready():
	# Set the predator's position a random position in the world
	position = Vector2(randf_range(0, 1920), randf_range(0, 1080))

func _process(delta):
	# Predator velocity is towards the target
	if state == PredatorState.ATTACKING:
		velocity = (target_stack.position - position).normalized() * speed
		move_and_slide()
		if is_in_stack:
			state = PredatorState.EATING
			timer.start()
	if state == PredatorState.FLEEING:
		velocity = -(target_stack.position - position).normalized() * speed * 2
		move_and_slide()
	elif state == PredatorState.HELD:
		global_position = get_global_mouse_position()

func on_press():
	state = PredatorState.HELD
			
func on_release():
	if is_in_stack:
		if Vivier.instance:
			Vivier.instance.instantiate_animal(kind)
			queue_free()
		else:
			push_error("No vivier instance in the scene!")
	else:
		state = PredatorState.FLEEING


func _on_timer_timeout():
	state = PredatorState.FLEEING
	Vivier.instance.remove_random_animal(kind)
