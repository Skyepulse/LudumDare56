extends CharacterBody2D

class_name Animal

enum AnimalType {
	SLUG = 0,
	TOAD =1,
	SNAKE = 2,
	CHICKEN = 3,
	FOX = 4,
	ALIEN = 5
}

var throwArrowPrefab: PackedScene = preload("res://PrefabScenes/red_arrow.tscn")
@onready var sprite : AnimatedSprite2D = $AnimatedSprite2D

@onready var collision_shape : CollisionShape2D = $CollisionShape2D

@onready var label = $Label

@export var speed : int
@export var max_throw_distance : float
@export var min_throw_distance : float
@export var type : AnimalType
@export var ui_sprite: Texture2D
@export var state : AnimalState

const FIRE: SpriteFrames = preload("res://fire.tres")

#===========Throw parameters================#
var throw_time: float = 0.5 # seconds, time for the animal to land once thrown
var throw_rotation_speed: float =  20.0# radians per second
var throw_value: float = 0
var actual_throw_distance: float = 0
var objective_position: Vector2 = Vector2(0,0)
var thrown_position: Vector2 = Vector2(0,0)

#===========Throw Arrow================#

var is_in_stack : bool = false
var is_in_throw_area : bool = false

var throw_arrow: ThrowArrow = null

enum AnimalState {
	STACKED = 0, # animal dans le stack
	HELD = 1, # animal pret a etre lance
	CROSSING = 2, #traverse la route
	FREE = 3, #animal sauvage mange les autres
	THROWN = 4, #animal lancé par le joueur avant d'aterrir et passer dans crossing
	SQUISHED = 5 #pretty self-explanatory
}

func move(delta: float) -> void :
	if (state == AnimalState.CROSSING) :
		rotation = 0;
		velocity = speed*Vector2(0,-1) * 0.002; # pour pas avoir à changer toutes les vitesses
		move_and_slide();
	elif (state == AnimalState.STACKED) :
		var collision_info = move_and_collide(10*velocity*delta);
		if (collision_info) :
			collide_wall();
	elif (state == AnimalState.FREE):
		pass #move towards stack, move away after timeout -> use direction var
	elif (state == AnimalState.HELD):
		global_transform.origin = get_global_mouse_position();
	elif state == AnimalState.THROWN:
		rotation += throw_rotation_speed * delta
		
		var direction = (objective_position - global_position).normalized()
		var distance_traveled = (thrown_position - global_position).length()
		var total_distance = (objective_position - thrown_position).length()

		if distance_traveled < total_distance / 2:
			var scale_factor = lerp(1.0, 2.0, distance_traveled / (total_distance / 2))
			sprite.scale = Vector2(scale_factor, scale_factor)
		else:
			var scale_factor = lerp(2.0, 1.0, (distance_traveled - total_distance / 2) / (total_distance / 2))
			sprite.scale = Vector2(scale_factor, scale_factor)

		if direction.y >= 0:
			state = AnimalState.CROSSING
			return

		var sp = actual_throw_distance / throw_time
		position += sp * direction * delta

func collide_wall() -> void :
	
	var angle= randf_range(-PI,PI);
	rotation = deg_to_rad(angle);
	velocity = Vector2(-cos(angle),-sin(angle));
	
func _ready() -> void:
	velocity = Vector2(cos(rotation),sin(rotation));
	
func _process(delta: float) -> void:
	move(delta);
	update_arrow_position();


var held = false

func on_press():
	if state != AnimalState.STACKED:
		return
	state = AnimalState.HELD
	ThrowArea.instance.highlight();
	if is_in_stack:
		if Vivier.instance:
			Vivier.instance.remove_animal(self.type)
			if Vivier.instance.get_animal_count(type) <= 1:
				label.show()
				
		else:
			push_error("No vivier instance in the scene!")
			
func on_release():
	label.hide()
	ThrowArea.instance.un_highlight();
	if state != AnimalState.STACKED and state != AnimalState.HELD:
		return
	if throw_arrow != null:
		configure_throw()
		remove_throw_arrow()	

	if !Vivier.instance:
		push_error("No vivier instance in the scene!")
		reset_throw_configuration()
		return

	if is_in_throw_area:
		state = AnimalState.THROWN
		return

	else:
		if !is_in_stack and !is_in_throw_area:
			self.position = Vivier.instance.spawn_position
		Vivier.instance.add_animal(self)
		reset_throw_configuration()
		state = AnimalState.STACKED

#====================================#
func configure_throw():
	if throw_arrow != null:
		throw_value = throw_arrow.throw_value
		actual_throw_distance = lerp(min_throw_distance, max_throw_distance, throw_value)
		objective_position = get_global_mouse_position() + Vector2(0, -actual_throw_distance)
		thrown_position = get_global_mouse_position()

func reset_throw_configuration():
	throw_value = 0
	actual_throw_distance = 0
	objective_position = Vector2(0,0)
	thrown_position = Vector2(0,0)

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
	var qlabel = Label.new()
	
	qlabel.text = "+%d" % value
	qlabel.add_theme_color_override("font_color", Color(1, 0, 0))
	qlabel.add_theme_font_size_override("font_size", 30)
	
	
	qlabel.position = spawn_point
	qlabel.rotation = 0
	
	get_tree().get_root().get_node("Level").add_child(qlabel)
	
	tween_floating_text(qlabel)
	
	queue_free_delayed(qlabel, 1.5)

func tween_floating_text(qlabel: Label):
	var tween = create_tween()
	# Animate the label moving upwards by 50 units in 1.5 seconds
	tween.tween_property(qlabel, "position:y", self.position.y - 50, 1.5)
	tween.tween_property(qlabel, "modulate:a", 0, 1.5)  # Fade out

func queue_free_delayed(qlabel: Label, seconds: float):
	await get_tree().create_timer(seconds).timeout
	qlabel.queue_free()

func squish():
	state = AnimalState.SQUISHED
	collision_shape.disabled = true;
	sprite.frames = FIRE
	sprite.play("burn")
