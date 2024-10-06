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
@export var state : AnimalState

var is_in_stack : bool = false

enum AnimalState {
	STACKED = 0, # animal dans le stack
	HELD = 1, # animal pret a etre lance
	CROSSING = 2, #traverse la route
	FREE = 3 #animal sauvage mange les autres
}

func move(delta: float) -> void :
	if (state == AnimalState.CROSSING) :
		rotation = 0;
		velocity = speed*Vector2(1,0)*delta;
		move_and_slide();
	elif (state == AnimalState.STACKED) :
		var collision_info = move_and_collide(10*velocity*delta);
		if (collision_info) :
			collide_wall();
	elif (state == AnimalState.FREE):
		pass #move towards stack, move away after timeout -> use direction var
	elif (state == AnimalState.HELD):
		global_transform.origin = get_global_mouse_position();

func collide_wall() -> void :
	
	var angle= randf_range(-PI,PI);
	rotation = deg_to_rad(angle);
	velocity = Vector2(-cos(angle),-sin(angle));
	
func _ready() -> void:
	rotation= randf_range(-PI,PI);
	velocity = Vector2(cos(rotation),sin(rotation));
	
func _process(delta: float) -> void:
	move(delta);


var held = false

func on_press():
	state = AnimalState.HELD
	if is_in_stack:
		if Vivier.instance:
			Vivier.instance.remove_animal(self.type)
		else:
			push_error("No vivier instance in the scene!")
			
func on_release():
	if is_in_stack:
		if Vivier.instance:
			Vivier.instance.add_animal(self)
		else:
			push_error("No vivier instance in the scene!")
		state = AnimalState.STACKED
	else:
		state = AnimalState.CROSSING

