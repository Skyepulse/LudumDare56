extends CharacterBody2D

class_name Animal

enum AnimalType {
	SLUG = 0,
	BETTER_SLUG= 1,
	TOAD =2,
	SNAKE = 3,
	CHICKEN = 4,
	FOX = 5,
	ALIEN = 6
}

@export var speed : int
@export var size : int
@export var throw_distance : int
@export var reproduction_rate : int
@export var type : AnimalType
@export var ui_sprite: Texture2D
@export var state : int



enum AnimalState {
	STACKED = 0, # animal dans le stack
	HELD = 1, # animal pret a etre lance
	CROSSING = 2, #traverse la route
	FREE = 3 #animal sauvage mange les autres
}

func move() -> void :
	if (state == AnimalState.CROSSING) :
		rotation = 0;
		velocity =speed*Vector2(1,0);
		move_and_slide();
	elif (state == AnimalState.STACKED) :
		rotation = 0;
		velocity = Vector2(-1,-1);
		move_and_slide();
	elif (state == AnimalState.FREE):
		pass #move towards stack, move away after timeout -> use direction var
	
func _process(delta: float) -> void:
	move();
