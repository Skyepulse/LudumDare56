extends Node2D

var voiture_rouge: PackedScene = preload("res://PrefabScenes/Voitures/Voiture_rouge.tscn")
var voiture_bleu: PackedScene = preload("res://PrefabScenes/Voitures/Voiture_bleu.tscn")
var camion: PackedScene = preload("res://PrefabScenes/Voitures/Camion.tscn")

@onready var road_1x_1 = $Road1x1
@onready var road_1x_2 = $Road1x2
var route

@onready var camera: Camera2D = get_node("../Camera2D")

@export var delay = 1 #Time between car
@export var car_speed = 200
@export var proba_gauche = 0.1
@export var proba_droite = 0.1
@export var proba_droite_2 = 0.1

@export var nbr_route = 3

var time_passed = 0.0

var top_left_position
var top_right_position
var top_right_position_2



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if nbr_route == 2:
		road_1x_2.hide()
		road_1x_1.show()
		route = road_1x_1
	elif nbr_route == 3:
		road_1x_2.show()
		road_1x_1.hide()
		route = road_1x_2
	#Camera
	var position_camera = camera.get_screen_center_position()
	var size_camera = get_viewport_rect().size

	top_left_position = (position_camera - (0.5*size_camera) + Vector2(0,102))
	top_right_position = (position_camera + (0.5*size_camera)*Vector2(1,-1) + Vector2(0,250))
	if nbr_route == 3:
		top_left_position = (position_camera - (0.5*size_camera) + Vector2(0,70))
		top_right_position = (position_camera + (0.5*size_camera)*Vector2(1,-1) + Vector2(0,200))
		top_right_position_2 = (position_camera + (0.5*size_camera)*Vector2(1,-1) + Vector2(0,290))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time_passed += delta  # Incrémente le temps écoulé

	if nbr_route == 2:
		var rand_gauche = randf()
		var rand_droite = randf()
		if time_passed >= delay:
			if rand_gauche <= proba_gauche: #probability that there is a car on delay
				voiture_move(top_left_position, true)
			if rand_droite <= proba_droite: #probability that there is a car on delay
				voiture_move(top_right_position, false)
			time_passed = 0.0

	elif nbr_route == 3:
		var rand_gauche = randf()
		var rand_droite_1 = randf()
		var rand_droite_2 = randf()
		if time_passed >= delay:
			if rand_gauche <= proba_gauche: #probability that there is a car on delay
				voiture_move(top_left_position, true)
			if rand_droite_1 <= proba_droite/2: #probability that there is a car on delay
				voiture_move(top_right_position, false)
			if rand_droite_2 <= proba_droite/2: #probability that there is a car on delay
				voiture_move(top_right_position_2, false)
			time_passed = 0.0

			
	   
func voiture_move(camera_position,a: bool ) -> void:
	var rand = randf()
	var voiture_instance
	if rand <=0.4:
		voiture_instance = voiture_rouge.instantiate()
	elif (rand <=0.8):
		voiture_instance = voiture_bleu.instantiate()
	else:
		voiture_instance = camion.instantiate()

	voiture_instance.get_node("AnimatedSprite2D").flip_h = a
	voiture_instance.scale.y = 1 / scale.y
	voiture_instance.speed = car_speed
	
	voiture_instance.direc = a
	add_child(voiture_instance)
	voiture_instance.position = camera_position
