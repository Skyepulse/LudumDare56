extends CharacterBody2D

class_name Predator

enum PredatorState {
	ATTACKING = 0,
	EATING = 1,
	FLEEING = 2,
	HELD = 3
}

var state: PredatorState = PredatorState.ATTACKING

var target_stack: Vivier
@export var speed = 50 

func _ready():
	# Set the predator's position a random position in the world
	position = Vector2(randf_range(0, 1920), randf_range(0, 1080))

func _process(delta):
	# Predator velocity is towards the target
	if state == PredatorState.ATTACKING:
		velocity = (target_stack.position - position).normalized() * speed
		move_and_slide()
	elif state == PredatorState.HELD:
		global_position = get_global_mouse_position()

func on_press():
	state = PredatorState.HELD
			
func on_release():
	state = PredatorState.ATTACKING
