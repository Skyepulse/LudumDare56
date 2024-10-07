extends Node2D

var voiture_rouge: PackedScene = preload("res://PrefabScenes/Voitures/Voiture_rouge.tscn")
var voiture_bleu: PackedScene = preload("res://PrefabScenes/Voitures/Voiture_bleu.tscn")
var camion: PackedScene = preload("res://PrefabScenes/Voitures/Camion.tscn")

@onready var route = $Road

@export var camera: Camera2D
@export var delay = 1 #Time between car
@export var car_speed = 200
@export var proba_droite = 0.1
@export var proba_gauche = 0.1
var time_passed = 0.0

var top_left_position
var top_right_position

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#Camera
	var position_camera = camera.get_screen_center_position()
	var size_camera = get_viewport_rect().size
	top_left_position = (position_camera - (0.5*size_camera) + Vector2(0,102))
	var top_route = (position_camera - (0.5*size_camera))

	top_right_position = (position_camera + (0.5*size_camera)*Vector2(1,-1) + Vector2(0,250))
	# route.position = top_route + Vector2(route.texture.get_width(),route.texture.get_height())/2

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time_passed += delta  # Incrémente le temps écoulé
	var rand_gauche = randf()
	var rand_droite = randf()

	if time_passed >= delay:
		if rand_gauche <= proba_droite: #probability that there is a car on delay
			voiture_move(top_left_position, 2, true)
		if rand_droite <= proba_gauche: #probability that there is a car on delay
			voiture_move(top_right_position, 1, false)
		time_passed = 0.0
			
	   
func voiture_move(camera_position, direc: int,a: bool ) -> void:
	var rand = randf()
	var voiture_instance
	if rand <=0.4:
		voiture_instance = voiture_rouge.instantiate()
	elif (rand <=0.8):
		voiture_instance = voiture_bleu.instantiate()
	else:
		voiture_instance = camion.instantiate()

	voiture_instance.get_node("AnimatedSprite2D").flip_h = a
	voiture_instance.speed = car_speed
	
	voiture_instance.direc = direc
	add_child(voiture_instance)
	voiture_instance.position = camera_position
