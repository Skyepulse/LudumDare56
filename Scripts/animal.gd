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

var throwArrowPrefab: PackedScene = preload("res://PrefabScenes/red_arrow.tscn")

@export var speed : int
@export var size : int
@export var throw_distance : int
@export var reproduction_rate : int
@export var type : AnimalType
@export var ui_sprite: Texture2D
@export var state : AnimalState

var is_in_stack : bool = false
var is_in_throw_area : bool = false

var throw_arrow: ThrowArrow = null

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
	update_arrow_position();


var held = false

func on_press():
	state = AnimalState.HELD
	if is_in_stack:
		if Vivier.instance:
			Vivier.instance.remove_animal(self.type)
		else:
			push_error("No vivier instance in the scene!")
			
func on_release():
	if throw_arrow != null:
		remove_throw_arrow()	

	if !Vivier.instance:
		push_error("No vivier instance in the scene!")
		return

	if is_in_throw_area:
		state = AnimalState.CROSSING
		return

	else:
		if !is_in_stack and !is_in_throw_area:
			self.position = Vivier.instance.spawn_position
		Vivier.instance.add_animal(self)
		state = AnimalState.STACKED

#====================================#
func add_throw_arrow():
	if throw_arrow == null and state == AnimalState.HELD:
		throw_arrow = throwArrowPrefab.instantiate()
		throw_arrow.position = get_global_mouse_position();
		get_tree().get_root().get_node("Level").add_child(throw_arrow)

func remove_throw_arrow():
	if throw_arrow != null:
		throw_arrow.queue_free()
		throw_arrow = null

func update_arrow_position():
	if throw_arrow != null:
		throw_arrow.position = get_global_mouse_position()
		
#===============Floating Label=====================#
func spawn_floating_label(value: int, spawn_point: Vector2):
	var label = Label.new()
	
	label.text = "+%d" % value
	label.add_theme_color_override("font_color", Color(1, 0, 0))
	label.add_theme_font_size_override("font_size", 30)
	
	
	label.position = spawn_point
	label.rotation = 0
	
	get_tree().get_root().get_node("Level").add_child(label)
	
	tween_floating_text(label)
	
	queue_free_delayed(label, 1.5)

func tween_floating_text(label: Label):
	var tween = create_tween()
	# Animate the label moving upwards by 50 units in 1.5 seconds
	tween.tween_property(label, "position:y", self.position.y - 50, 1.5)
	tween.tween_property(label, "modulate:a", 0, 1.5)  # Fade out

func queue_free_delayed(label: Label, seconds: float):
	await get_tree().create_timer(seconds).timeout
	label.queue_free()