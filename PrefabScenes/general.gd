extends Node2D

var voiture_rouge: PackedScene = preload("res://PrefabScenes/Voiture_rouge.tscn")
var voiture_bleu: PackedScene = preload("res://PrefabScenes/Voiture_bleu.tscn")
var camion: PackedScene = preload("res://PrefabScenes/Camion.tscn")

var road: PackedScene = preload("res://PrefabScenes/sprite_2d.tscn")

var delay = 0.15 #Time between car
var time_passed = 0.0

var top_left_position
var top_right_position

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var route = road.instantiate()
	add_child(route)

	#Camera
	var camera = $Camera2D
	var position_camera = camera.get_screen_center_position()
	var size_camera = get_viewport_rect().size
	top_left_position = (position_camera - (0.5*size_camera) + Vector2(0,102))
	var top_route = (position_camera - (0.5*size_camera))

	top_right_position = (position_camera + (0.5*size_camera)*Vector2(1,-1) + Vector2(0,250))
	route.position = top_route + Vector2(route.texture.get_width(),route.texture.get_height())/2

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time_passed += delta  # Incrémente le temps écoulé
	var rand_gauche = randf()
	var rand_droite = randf()

	if time_passed >= delay:
		if rand_gauche <= 0.1: #probability that there is a car on delay
			voiture_move(top_left_position, 2)
		if rand_droite <= 0.1: #probability that there is a car on delay
			voiture_move(top_right_position, 1)
		time_passed = 0.0
			
	   
func voiture_move(camera_position, direc: int) -> void:
	var rand = randf()
	var voiture_instance
	if rand <=0.4:
		voiture_instance = voiture_rouge.instantiate()
	elif (rand <=0.8):
		voiture_instance = voiture_bleu.instantiate()
	else:
		voiture_instance = camion.instantiate()

	voiture_instance.direc = direc
	add_child(voiture_instance)
	voiture_instance.position = camera_position
